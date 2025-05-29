import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twist_chat/common/notification_plugin.dart';

part 'notification.g.dart';

@riverpod
class Notification extends _$Notification {
  static const _prefsKey = 'unread_chats';

  @override
  Future<Set<String>> build() async {
    final prefs = await SharedPreferences.getInstance();
    final ids = prefs.getStringList(_prefsKey) ?? [];
    return ids.toSet();
  }

  /// Marca o chat como lido: remove do Set e persiste
  Future<void> openChat(String chatId) async {
    // get the current set (or empty)
    final current = state.value ?? <String>{};
    // make a brand‑new Set without that chatId
    final updated = Set<String>.from(current)..remove(chatId);

    // assign it back to state so Riverpod rebuilds
    state = AsyncValue.data(updated);

    // save to prefs
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_prefsKey, updated.toList());
  }

  Future<void> handleIncomingMessage(RemoteMessage message) async {
    debugPrint('FCM payload: ${message.data}');

    final chatId = message.data['chat_id'] as String?;
    if (chatId == null) return;

    // Show a notification (still on the main isolate, but now it's the *only* work here)
    final current = state.value ?? <String>{};
    // make a brand‑new Set without that chatId
    final updated = Set<String>.from(current)..add(chatId);

    // assign it back to state so Riverpod rebuilds
    state = AsyncValue.data(updated);

    // save to prefs
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_prefsKey, updated.toList());

    final android = AndroidNotificationDetails(
      'default',
      'Default',
      importance: Importance.max,
      priority: Priority.high,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      '${message.data['sender_name']} says:',
      message.data['text'],
      NotificationDetails(android: android),
      payload: message.data['chat_id'],
    );
  }
}
