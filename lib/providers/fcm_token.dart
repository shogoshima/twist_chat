import 'package:firebase_messaging/firebase_messaging.dart';
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
    final messaging = FirebaseMessaging.instance;
    messaging.onRegistered.listen((token) async {
      await ref.read(apiClientProvider).put(ApiRoutes.fcm, {
        'fcm_token': token,
      });
    });

    // Registering emits the Firebase Installation ID used for direct sends.
    await messaging.register();
  }
}
