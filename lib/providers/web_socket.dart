import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:twist_chat/models/models.dart';
import 'package:twist_chat/models/web_socket_action.dart';
import 'package:twist_chat/providers/global_chat.dart';
import 'package:twist_chat/providers/google_auth.dart';
import 'package:twist_chat/providers/single_chat.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'web_socket.g.dart';

// const String wsUrl = 'wss://shogoshima.duckdns.org/ws';
const String wsUrl = 'ws://192.168.15.6:8080/ws';

@riverpod
class WebSocket extends _$WebSocket {
  WebSocketChannel? _channel;
  String? _userId;
  Timer? _reconnectTimer;
  final Duration _reconnectDelay = const Duration(seconds: 1);

  /// The build method is used for initialization.
  /// Here we await for the Google authentication and then create the connection.
  @override
  Future<WebSocketChannel?> build() async {
    ref.onDispose(() {
      _reconnectTimer?.cancel();
      _channel?.sink.close();
      _channel = null;
      _userId = null;
    });

    // Watch the authentication provider.
    final User? user = ref.watch(googleAuthProvider).value;
    if (user == null) return null;

    _userId = user.id;
    await _connect();

    return _channel;
  }

  /// Connects to the WebSocket endpoint using the authenticated user’s ID.
  Future<void> _connect() async {
    try {
      _channel = WebSocketChannel.connect(Uri.parse('$wsUrl/$_userId'));

      // Update our state with the new channel.
      state = AsyncData(_channel);

      // Listen for incoming messages and handle reconnections.
      _channel!.stream.listen(
        _handleIncomingMessage,
        onError: (error) {
          debugPrint('WebSocket error: $error');
          _scheduleReconnect();
        },
        onDone: () {
          debugPrint('WebSocket closed');
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
}
