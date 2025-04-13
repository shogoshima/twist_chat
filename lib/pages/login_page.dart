import 'package:flutter/material.dart';
import 'package:twist_chat/widgets/widgets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TwistChat')),
      body: Center(child: SignInButton()),
    );
  }
}
