import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twist_chat/common/notification_plugin.dart';
import 'package:twist_chat/common/theme.dart';
import 'package:twist_chat/pages/pages.dart';
import 'package:twist_chat/providers/auth.dart';
import 'package:twist_chat/providers/observer.dart';

import 'firebase_options.dart';

// Runs in its own isolate; the pragma keeps release builds from tree-shaking it.
@pragma('vm:entry-point')
Future<void> _backgroundHandler(RemoteMessage message) async {
  debugPrint(message.toString());
  // ONLY data processing here. No flutterLocalNotificationsPlugin.show()
  if (message.data.isEmpty) return;
  // e.g. save message.data to SharedPreferences or DB
}

Future<void> _setupFlutterNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('notification_icon');
  const DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings();

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
  );

  await flutterLocalNotificationsPlugin.initialize(
    settings: initializationSettings,
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Independent plugin setups: run them concurrently to shorten startup.
  await Future.wait([
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
    GoogleSignIn.instance.initialize(),
    _setupFlutterNotifications(),
  ]);
  FirebaseMessaging.onBackgroundMessage(_backgroundHandler);

  runApp(
    ProviderScope(
      observers: [if (kDebugMode) MyObserver()],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Twist Chat',
      theme: theme,
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return switch (ref.watch(authStateProvider)) {
      // Se houver um usuário logado, vai para HomePage
      AsyncData(value: _?) => const HomePage(),
      // Caso contrário, vai para LoginPage
      AsyncData() || AsyncError() => const LoginPage(),
      // Enquanto aguarda a primeira emissão, exibe um loading
      _ => const Scaffold(body: Center(child: CircularProgressIndicator())),
    };
  }
}
