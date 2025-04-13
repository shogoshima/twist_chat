import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twist_chat/models/models.dart';
import 'package:twist_chat/providers/google_auth.dart';
import 'package:twist_chat/widgets/profile_card.dart';

class AccountPage extends ConsumerWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<User?> user = ref.watch(googleAuthProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: switch (user) {
            AsyncData(:final value) => Column(
              children: [
                ProfileCard(
                  name: value!.name,
                  username: value.username,
                  photoUrl: value.photoUrl,
                ),
              ],
            ),
            AsyncError() => const Text('Oops, something unexpected happened'),
            _ => const CircularProgressIndicator(),
          },
        ),
        ElevatedButton(
          onPressed: () {
            ref.read(googleAuthProvider.notifier).logout();
          },
          child: Text('Logout'),
        ),
      ],
    );
  }
}
