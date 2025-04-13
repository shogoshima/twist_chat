import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:twist_chat/common/theme.dart';
import 'package:twist_chat/pages/pages.dart';
import 'package:twist_chat/providers/google_auth.dart';
import 'package:twist_chat/providers/observer.dart';

void main() {
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

class AuthWrapper extends ConsumerStatefulWidget {
  const AuthWrapper({super.key});

  @override
  ConsumerState<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends ConsumerState<AuthWrapper> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ref.watch(googleAuthProvider.future),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: Colors.white, // Explicitly set background color
            body: Center(child: CircularProgressIndicator()),
          );
        } else {
          return snapshot.hasData ? const HomePage() : const LoginPage();
        }
      },
    );
  }
}
