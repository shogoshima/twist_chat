import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
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
  final Duration _reconnectDelay = const Duration(milliseconds: 500);
  bool _disposed = false;

  /// The build method is used for initialization.
  /// Here we await for the Google authentication and then create the connection.
  @override
  Future<WebSocketChannel?> build() async {
    ref.onDispose(() {
      _reconnectTimer?.cancel();
      _channel?.sink.close();
      _channel = null;
      _user = null;
      _userId = null;
      _idToken = null;
      _disposed = true;
    });

    // Watch the authentication state so we reconnect on login and close on logout.
    final User? user = await ref.watch(authStateProvider.future);
    if (user == null) return null;

    _user = user;
    _userId = user.uid;

    await _connect();

    return _channel;
  }

  /// Connects to the WebSocket endpoint using the authenticated user’s ID.
  Future<void> _connect() async {
    if (_disposed) return;

    final user = _user;
    if (user == null) return;

    try {
      // Fetch the token on every (re)connection: Firebase ID tokens expire
      // after an hour, so a cached one would be rejected on a late reconnect.
      // getIdToken() returns the cached token while valid and refreshes it
      // transparently once expired.
      _idToken = await user.getIdToken();
      if (_idToken == null) {
        throw StateError('Firebase did not return an ID token.');
      }

      _channel = WebSocketChannel.connect(Uri.parse('$wsUrl/$_userId'));

      sendAuthentication();

      // Update our state with the new channel.
      state = AsyncData(_channel);

      // Listen for incoming messages and handle reconnections.
      _channel!.stream.listen(
        _handleIncomingMessage,
        onError: (error) {
          debugPrint('WebSocket error: $error');
          _channel = null;
          _scheduleReconnect();
        },
        onDone: () {
          debugPrint('WebSocket closed');
          _channel = null;
          _scheduleReconnect();
        },
      );
    } catch (e, stackTrace) {
      debugPrint('Connection exception: $e');
      state = AsyncError(e, stackTrace);
      _scheduleReconnect();
    }
  }

  /// Schedules a reconnection after a set delay.
  void _scheduleReconnect() {
    if (_disposed) return;

    _channel?.sink.close();
    state = const AsyncData(null);
    if (_reconnectTimer?.isActive ?? false) return;
    _reconnectTimer = Timer(_reconnectDelay, () => _connect());
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

        final newMessage = Message(
          id: message.id,
          chatId: message.chatId,
          senderId: message.senderId,
          text: message.text,
          sentAt: message.sentAt,
        );

        ref
            .read(singleChatProvider(message.chatId).notifier)
            .addMessage(newMessage);
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
