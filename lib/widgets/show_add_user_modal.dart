import 'dart:developer';
import 'package:avatar_stack/animated_avatar_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twist_chat/models/models.dart';
import 'package:twist_chat/providers/search_user.dart';
import 'package:twist_chat/providers/single_chat.dart';

Future<void> showAddUserModal(
  BuildContext context,
  WidgetRef ref,
  String chatId,
  List<User> presentParticipants,
) {
  final TextEditingController usernameController = TextEditingController();
  List<User> selectedUsers = [];

  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Padding(
            // Adjust for soft keyboard
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildHeader(context),
                  SizedBox(height: 16),
                  _buildSelectedUsersPreview(selectedUsers),
                  SizedBox(height: 16),
                  _buildUserSearchField(
                    context,
                    ref,
                    usernameController,
                    presentParticipants,
                    selectedUsers,
                    setState,
                  ),
                  SizedBox(height: 16),
                  _buildAddParticipantsButton(
                    context,
                    ref,
                    chatId,
                    selectedUsers,
                  ),
                  SizedBox(height: 32),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

// Header with title and close button.
Widget _buildHeader(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SizedBox(width: 48),
      Text(
        'Add More Participants',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () => Navigator.of(context).pop(),
      ),
    ],
  );
}

// Display selected user avatars with an AnimatedSwitcher.
Widget _buildSelectedUsersPreview(List<User> selectedUsers) {
  return AnimatedSwitcher(
    duration: Duration(milliseconds: 300),
    transitionBuilder: (Widget child, Animation<double> animation) {
      return SizeTransition(
        sizeFactor: animation,
        axis: Axis.vertical,
        axisAlignment: -1.0,
        child: child,
      );
    },
    child:
        selectedUsers.isEmpty
            ? SizedBox(key: ValueKey('empty'))
            : Padding(
              key: ValueKey('participants'),
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: AnimatedAvatarStack(
                height: 60,
                avatars: [
                  for (var i = 0; i < selectedUsers.length; i++)
                    NetworkImage(selectedUsers[i].photoUrl),
                ],
              ),
            ),
  );
}

// Build the search text field to add a new user.
Widget _buildUserSearchField(
  BuildContext context,
  WidgetRef ref,
  TextEditingController usernameController,
  List<User> presentParticipants,
  List<User> selectedUsers,
  StateSetter setState,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: TextField(
      controller: usernameController,
      decoration: InputDecoration(
        labelText: 'Add participants',
        border: OutlineInputBorder(),
        hintText: 'Enter username',
        suffixIcon: IconButton(
          icon: Icon(Icons.person_add_alt),
          onPressed: () async {
            final username = usernameController.text.trim();
            if (username.isNotEmpty) {
              try {
                final userData = await ref.read(
                  searchUserProvider(username).future,
                );
                if (userData == null) return;
                // Only add if not already in the list.
                if (!presentParticipants.contains(userData) &&
                    !selectedUsers.contains(userData)) {
                  setState(() {
                    selectedUsers.add(userData);
                  });
                  usernameController.clear();
                }
              } catch (error) {
                log(error.toString());
              }
            }
          },
        ),
      ),
    ),
  );
}

// Build the button to add participants.
Widget _buildAddParticipantsButton(
  BuildContext context,
  WidgetRef ref,
  String chatId,
  List<User> selectedUsers,
) {
  return AnimatedSwitcher(
    duration: Duration(milliseconds: 300),
    transitionBuilder: (Widget child, Animation<double> animation) {
      return SizeTransition(
        sizeFactor: animation,
        axis: Axis.vertical,
        axisAlignment: -1.0,
        child: child,
      );
    },
    child:
        selectedUsers.isEmpty
            ? SizedBox(key: ValueKey('empty'))
            : Padding(
              key: ValueKey('button'),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: FilledButton(
                onPressed: () {
                  try {
                    ref
                        .read(singleChatProvider(chatId).notifier)
                        .addParticipants(
                          selectedUsers.map((e) => e.username).toList(),
                        );

                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  } catch (error) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('Error: $error')));
                    Navigator.of(context).pop();
                  }
                },
                style: FilledButton.styleFrom(
                  minimumSize: Size(double.infinity, 48),
                ),
                child: Text('Add participants'),
              ),
            ),
  );
}
