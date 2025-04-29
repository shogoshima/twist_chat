import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twist_chat/providers/auth.dart';
import 'package:twist_chat/widgets/profile_card.dart';
import 'package:twist_chat/widgets/show_dialog.dart';

class AccountPage extends ConsumerWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = FirebaseAuth.instance.currentUser!;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ProfileCard(
          name: currentUser.displayName!,
          username: currentUser.email!.split('@')[0],
          photoUrl: currentUser.photoURL!,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Column(
              children: [
                ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  title: Text('Delete records'),
                  onTap: () {
                    showConfirmDialog(
                      context,
                      'Delete records',
                      'This will erase all your data and conversations for good. There’s no way to get them back.\n\nDo you really want to go ahead?',
                      () {
                        ref.read(authProvider.notifier).delete();
                      },
                    );
                  },
                ),
                ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  title: Text('Logout'),
                  onTap: () {
                    ref.read(authProvider.notifier).logout();
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
