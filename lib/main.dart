import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:twist_chat/common/notification_plugin.dart';
import 'package:twist_chat/common/theme.dart';
import 'package:twist_chat/pages/pages.dart';
import 'package:twist_chat/providers/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> _backgroundHandler(RemoteMessage message) async {
  debugPrint(message.toString());
  // ONLY data processing here. No flutterLocalNotificationsPlugin.show()
  if (message.data.isEmpty) return;
  // e.g. save message.data to SharedPreferences or DB
}

Future<void> _setupFlutterNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('notification_icon');
  final DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings();

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_backgroundHandler);

  await _setupFlutterNotifications();

  runApp(ProviderScope(observers: [MyObserver()], child: const MyApp()));
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

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Enquanto aguarda a primeira emissão, exibe um loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Se houver um usuário logado, vai para HomePage
        if (snapshot.hasData && snapshot.data != null) {
          return const HomePage();
        }

        // Caso contrário, vai para LoginPage
        return const LoginPage();
      },
    );
  }
}
