import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:twist_chat/models/models.dart';
import 'package:twist_chat/models/web_socket_authentication.dart';
import 'package:twist_chat/providers/auth.dart';
import 'package:twist_chat/providers/global_chat.dart';
import 'package:twist_chat/providers/single_chat.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'web_socket.g.dart';

const String wsUrl = 'wss://shogoshima.duckdns.org/ws';
// const String wsUrl = 'ws://192.168.15.6:8080/ws';

/// App-wide connection: lives for the whole session and is rebuilt (closing the
/// previous channel) whenever the signed-in user changes.
@Riverpod(keepAlive: true)
class WebSocket extends _$WebSocket {
  WebSocketChannel? _channel;
  User? _user;
  String? _userId;
  String? _idToken;
  Timer? _reconnectTimer;
  AppLifecycleListener? _lifecycleListener;
  final Duration _initialReconnectDelay = const Duration(milliseconds: 500);
  final Duration _maxReconnectDelay = const Duration(seconds: 30);
  int _reconnectAttempts = 0;
  final Random _random = Random();

  /// Bumped on every dispose. The notifier instance survives rebuilds, so a
  /// connection attempt still awaiting its token compares against this to
  /// know it belongs to a previous session.
  int _session = 0;

  /// The build method is used for initialization.
  /// Here we await for the Google authentication and then create the connection.
  @override
  Future<WebSocketChannel?> build() async {
    ref.onDispose(() {
      _session++;
      _reconnectTimer?.cancel();
      _lifecycleListener?.dispose();
      _lifecycleListener = null;
      _channel?.sink.close();
      _channel = null;
      _user = null;
      _userId = null;
      _idToken = null;
      _reconnectAttempts = 0;
    });

    // Watch the authentication state so we reconnect on login and close on logout.
    final User? user = await ref.watch(authStateProvider.future);
    if (user == null) return null;

    _user = user;
    _userId = user.uid;
    // The backoff can grow while the app is suspended; retry right away when
    // the user comes back instead of waiting it out.
    _lifecycleListener = AppLifecycleListener(onResume: _reconnectNow);

    await _connect();

    return _channel;
  }

  /// Connects to the WebSocket endpoint using the authenticated user’s ID.
  Future<void> _connect() async {
    final user = _user;
    if (user == null) return;
    final session = _session;

    try {
      // Fetch the token on every (re)connection: Firebase ID tokens expire
      // after an hour, so a cached one would be rejected on a late reconnect.
      // getIdToken() returns the cached token while valid and refreshes it
      // transparently once expired.
      _idToken = await user.getIdToken();
      if (session != _session) return;
      if (_idToken == null) {
        throw StateError('Firebase did not return an ID token.');
      }

      final channel = WebSocketChannel.connect(Uri.parse('$wsUrl/$_userId'));
      _channel = channel;

      sendAuthentication();

      // Update our state with the new channel.
      state = AsyncData(channel);

      // Listen for incoming messages and handle reconnections.
      channel.stream.listen(
        _handleIncomingMessage,
        onError: (error) {
          debugPrint('WebSocket error: $error');
          _onChannelClosed(channel);
        },
        onDone: () {
          debugPrint('WebSocket closed');
          _onChannelClosed(channel);
        },
      );

      // Connection failures also reach the stream above, so only the success
      // path matters here.
      unawaited(
        channel.ready.then<void>((_) {
          if (identical(channel, _channel)) _reconnectAttempts = 0;
        }, onError: (Object _) {}),
      );
    } catch (e, stackTrace) {
      if (session != _session) return;
      debugPrint('Connection exception: $e');
      state = AsyncError(e, stackTrace);
      _scheduleReconnect();
    }
  }

  void _onChannelClosed(WebSocketChannel channel) {
    // Late events from a channel we already replaced must not tear down the
    // current one.
    if (!identical(channel, _channel)) return;
    _scheduleReconnect();
  }

  /// Schedules a reconnection with exponential backoff.
  void _scheduleReconnect() {
    if (_user == null) return;

    _channel?.sink.close();
    _channel = null;
    state = const AsyncData(null);
    if (_reconnectTimer?.isActive ?? false) return;
    _reconnectTimer = Timer(_nextReconnectDelay(), () => _connect());
  }

  /// Doubles the delay on each failed attempt up to [_maxReconnectDelay], with
  /// ±20% jitter so clients don't retry in lockstep after a server restart.
  Duration _nextReconnectDelay() {
    final exponential =
        _initialReconnectDelay * pow(2, min(_reconnectAttempts, 6));
    _reconnectAttempts++;
    final capped = exponential > _maxReconnectDelay
        ? _maxReconnectDelay
        : exponential;
    return capped * (0.8 + _random.nextDouble() * 0.4);
  }

  /// Skips the pending backoff, if any, and reconnects immediately.
  void _reconnectNow() {
    if (!(_reconnectTimer?.isActive ?? false)) return;
    _reconnectTimer!.cancel();
    _reconnectAttempts = 0;
    _connect();
  }

  /// Process incoming messages from the WebSocket.
  void _handleIncomingMessage(dynamic raw) {
    try {
      final decoded = jsonDecode(raw);
      if (decoded['type'] == 'error') {
        final msg = decoded['payload']['message'];
        throw Exception(msg);
      } else if (decoded['type'] == 'action') {
        final action = WebSocketAction.fromJson(decoded['payload']);
        debugPrint(action.toString());
        if (action.type == 'refresh_summary') {
          ref.invalidate(globalChatProvider);
        } else if (action.type == 'refresh_details') {
          ref.invalidate(globalChatProvider);
          ref.invalidate(singleChatProvider(action.chatId));
        }
      } else {
        final message = WebSocketMessage.fromJson(decoded['payload']);

        // Read the chat operation provider.
        final chats = ref.read(globalChatProvider).value;
        if (chats == null) return;

        // If I don't have the chat on my global chat list, I fetch
        final bool exists = chats.any((chat) => chat.chatId == message.chatId);
        if (!exists) {
          // Fetch the new chat
          ref.read(globalChatProvider.notifier).fetchNewChat(message.chatId);
          return;
        }

        // Chats that were never opened have no details loaded. Reading their
        // notifier would fetch the whole chat for a single message, so only
        // bump the list entry; the details load when the chat is opened.
        final chatProvider = singleChatProvider(message.chatId);
        if (!ref.exists(chatProvider)) {
          ref
              .read(globalChatProvider.notifier)
              .updateChat(message.chatId, message.text);
          return;
        }

        final newMessage = Message(
          id: message.id,
          chatId: message.chatId,
          senderId: message.senderId,
          text: message.text,
          sentAt: message.sentAt,
        );

        ref.read(chatProvider.notifier).addMessage(newMessage);
      }
    } catch (e) {
      debugPrint('Error handling incoming message: $e');
    }
  }

  /// Public method for sending messages.
  /// If no channel is active, you might consider queuing the messages.
  void sendMessage(WebSocketMessage message) {
    if (_channel != null) {
      _channel!.sink.add(jsonEncode({'type': 'message', 'data': message}));
      debugPrint('Sent message');
    } else {
      debugPrint('Connection not established. Message not sent.');
      // Optionally implement a queuing mechanism here.
    }
  }

  void sendAction(WebSocketAction action) {
    if (_channel != null) {
      _channel!.sink.add(jsonEncode({'type': 'action', 'data': action}));
      debugPrint('Sent action');
    } else {
      debugPrint('Connection not established. Action not sent.');
    }
  }

  void sendAuthentication() {
    if (_channel != null && _idToken != null) {
      final authentication = WebSocketAuthentication(idToken: _idToken!);
      _channel!.sink.add(
        jsonEncode({'type': 'authentication', 'data': authentication}),
      );
      debugPrint('Sent authentication');
    } else {
      debugPrint('Connection not established. Authentication not sent.');
    }
  }
}
