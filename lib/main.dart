import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      home: const TwistChatBootstrap(),
    );
  }
}

class TwistChatBootstrap extends StatefulWidget {
  const TwistChatBootstrap({super.key});

  @override
  State<TwistChatBootstrap> createState() => _TwistChatBootstrapState();
}

class _TwistChatBootstrapState extends State<TwistChatBootstrap> {
  late Future<void> _firebaseInitialization;

  @override
  void initState() {
    super.initState();
    _firebaseInitialization = _initializeFirebase();
  }

  Future<void> _initializeFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);

    // These plugins are useful after launch but must not hold the app at its
    // native splash screen if setup fails on a particular device.
    unawaited(_initializeOptionalPlugins());
  }

  Future<void> _initializeOptionalPlugins() async {
    try {
      await initializeGoogleSignIn();
    } catch (error, stackTrace) {
      debugPrint('Google Sign-In initialization failed: $error\n$stackTrace');
    }

    try {
      await _setupFlutterNotifications();
    } catch (error, stackTrace) {
      debugPrint('Notification initialization failed: $error\n$stackTrace');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _firebaseInitialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return StartupErrorPage(
            onRetry: () {
              setState(() {
                _firebaseInitialization = _initializeFirebase();
              });
            },
          );
        }

        if (snapshot.connectionState != ConnectionState.done) {
          return const LoadingPage();
        }

        return const AuthWrapper();
      },
    );
  }
}

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return switch (ref.watch(authStateProvider)) {
      // If a user is signed in, navigate to HomePage.
      AsyncData(value: _?) => const HomePage(),
      // Otherwise, navigate to LoginPage.
      AsyncData() || AsyncError() => const LoginPage(),
      // Show a loading indicator while waiting for the first event.
      _ => const LoadingPage(),
    };
  }
}
