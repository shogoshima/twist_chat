import 'dart:developer';
import 'package:avatar_stack/animated_avatar_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twist_chat/models/models.dart';
import 'package:twist_chat/providers/global_chat.dart';
import 'package:twist_chat/providers/google_auth.dart';
import 'package:twist_chat/providers/search_user.dart';

Future<void> showCreateChatModal(BuildContext context, WidgetRef ref) {
  // Controllers and keys.
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController groupNameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Current logged in user.
  final user = ref.read(googleAuthProvider).value;
  // In-memory selected users list.
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
            // Adjust for soft keyboard.
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildHeader(context),
                  _buildSelectedUsers(user!, selectedUsers),
                  _buildSearchField(
                    context,
                    ref,
                    usernameController,
                    selectedUsers,
                    setState,
                  ),
                  _buildGroupNameInput(
                    formKey,
                    groupNameController,
                    selectedUsers,
                  ),
                  SizedBox(height: 16),
                  _buildCreateChatButton(
                    context,
                    ref,
                    selectedUsers,
                    groupNameController,
                    formKey,
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

// HEADER: AppBar like header with title and close button.
Widget _buildHeader(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SizedBox(width: 48),
      Text(
        'New Chat',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () => Navigator.of(context).pop(),
      ),
    ],
  );
}

// SELECTED USERS: Display the current selected users using AnimatedAvatarStack.
Widget _buildSelectedUsers(User currentUser, List<User> selectedUsers) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: AnimatedAvatarStack(
      height: 60,
      avatars: [
        // The current user's photo is always shown.
        NetworkImage(currentUser.photoUrl),
        // Then add the selected users.
        for (var user in selectedUsers) NetworkImage(user.photoUrl),
      ],
    ),
  );
}

// SEARCH FIELD: Display a text field for searching a user.
Widget _buildSearchField(
  BuildContext context,
  WidgetRef ref,
  TextEditingController usernameController,
  List<User> selectedUsers,
  StateSetter setState,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: TextField(
      controller: usernameController,
      decoration: InputDecoration(
        labelText: 'Search for a user',
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
                // Only add if not already in list and not the current user.
                if (userData != ref.read(googleAuthProvider).value &&
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

// GROUP NAME INPUT: If there is more than one selected user, display a form to input group name.
Widget _buildGroupNameInput(
  GlobalKey<FormState> formKey,
  TextEditingController groupNameController,
  List<User> selectedUsers,
) {
  return AnimatedSwitcher(
    duration: const Duration(milliseconds: 300),
    transitionBuilder: (Widget child, Animation<double> animation) {
      return SizeTransition(
        sizeFactor: animation,
        axis: Axis.vertical,
        axisAlignment: -1.0,
        child: child,
      );
    },
    child:
        selectedUsers.length <= 1
            ? SizedBox(key: ValueKey('empty'))
            : Padding(
              key: ValueKey('groupName'),
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Form(
                key: formKey,
                child: TextFormField(
                  controller: groupNameController,
                  decoration: InputDecoration(
                    labelText: 'Enter a group name*',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Group name required';
                    }
                    if (value.length > 30) {
                      return 'Group name too long';
                    }
                    return null;
                  },
                ),
              ),
            ),
  );
}

// CREATE CHAT BUTTON: Button to create a chat (single or group).
Widget _buildCreateChatButton(
  BuildContext context,
  WidgetRef ref,
  List<User> selectedUsers,
  TextEditingController groupNameController,
  GlobalKey<FormState> formKey,
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
                    if (selectedUsers.length == 1) {
                      // Create single chat
                      ref
                          .read(globalChatProvider.notifier)
                          .createNewSingleChat(selectedUsers[0].username);

                      if (!context.mounted) return;
                      Navigator.of(context).pop();
                    } else {
                      // Create group chat
                      if (formKey.currentState!.validate()) {
                        ref
                            .read(globalChatProvider.notifier)
                            .createNewGroupChat(
                              selectedUsers
                                  .map((user) => user.username)
                                  .toList(),
                              groupNameController.text,
                            );

                        if (!context.mounted) return;
                        Navigator.of(context).pop();
                      }
                    }
                  } catch (error) {
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('Error: $error')));
                    Navigator.of(context).pop();
                  }
                },
                style: FilledButton.styleFrom(
                  minimumSize: Size(double.infinity, 48),
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (
                    Widget child,
                    Animation<double> animation,
                  ) {
                    return ScaleTransition(scale: animation, child: child);
                  },
                  child:
                      selectedUsers.length == 1
                          ? Text('Create DM', key: ValueKey('single'))
                          : Text('Create Group Chat', key: ValueKey('group')),
                ),
              ),
            ),
  );
}
