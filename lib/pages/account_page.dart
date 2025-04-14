import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twist_chat/models/models.dart';
import 'package:twist_chat/providers/google_auth.dart';
import 'package:twist_chat/widgets/profile_card.dart';
import 'package:twist_chat/widgets/show_dialog.dart';

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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Column(
              children: [
                ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  title: Text('Delete records'),
                  onTap: () {
                    showConfirmDialog(
                      context,
                      'Delete records',
                      'This will erase all your data and conversations for good. There’s no way to get them back.\n\nDo you really want to go ahead?',
                      () {
                        ref.read(googleAuthProvider.notifier).delete();
                      },
                    );
                  },
                ),
                ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  title: Text('Logout'),
                  onTap: () {
                    ref.read(googleAuthProvider.notifier).logout();
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
