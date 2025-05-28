import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:twist_chat/providers/api_client.dart';

part 'fcm_token.g.dart';

@riverpod
Future<void> fcmToken(Ref ref) async {
  // 1. Request permission on iOS
  final settings = await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized ||
      settings.authorizationStatus == AuthorizationStatus.provisional) {
    // 2. Get token
    final token = await FirebaseMessaging.instance.getToken();

    // 3. Send to backend if not null
    if (token != null) {
      await ref.read(apiClientProvider).put(ApiRoutes.fcm, {
        'fcm_token': token,
      });
    }

    // 4. Handle token refresh
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
      await ref.read(apiClientProvider).put(ApiRoutes.fcm, {
        'fcm_token': newToken,
      });
    });
  }
}
