import 'dart:developer';

import 'package:avatar_stack/animated_avatar_stack.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twist_chat/common/validators.dart';
import 'package:twist_chat/models/models.dart';
import 'package:twist_chat/providers/global_chat.dart';
import 'package:twist_chat/providers/search_user.dart';
import 'package:twist_chat/widgets/modal_header.dart';
import 'package:twist_chat/widgets/size_switcher.dart';

Future<void> showCreateChatModal(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) => const _CreateChatSheet(),
  );
}

class _CreateChatSheet extends ConsumerStatefulWidget {
  const _CreateChatSheet();

  @override
  ConsumerState<_CreateChatSheet> createState() => _CreateChatSheetState();
}

class _CreateChatSheetState extends ConsumerState<_CreateChatSheet> {
  final _usernameController = TextEditingController();
  final _groupNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final List<Profile> _selectedUsers = [];
  bool _submitting = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _groupNameController.dispose();
    super.dispose();
  }

  Future<void> _addUser() async {
    final username = _usernameController.text.trim();
    if (username.isEmpty) return;

    try {
      final user = await ref.read(searchUserProvider(username).future);
      if (user == null || !mounted) return;
      // Only add if not already in list and not the current user.
      if (user.id == FirebaseAuth.instance.currentUser!.uid ||
          _selectedUsers.contains(user)) {
        return;
      }
      setState(() => _selectedUsers.add(user));
      _usernameController.clear();
    } catch (error) {
      log(error.toString());
    }
  }

  Future<void> _createChat() async {
    final isGroup = _selectedUsers.length > 1;
    if (isGroup && !_formKey.currentState!.validate()) return;

    setState(() => _submitting = true);
    final chats = ref.read(globalChatProvider.notifier);
    final messenger = ScaffoldMessenger.of(context);
    try {
      if (isGroup) {
        await chats.createNewGroupChat(
          _selectedUsers.map((user) => user.username).toList(),
          _groupNameController.text,
        );
      } else {
        await chats.createNewSingleChat(_selectedUsers.single.username);
      }
    } catch (error) {
      messenger.showSnackBar(SnackBar(content: Text('Error: $error')));
    }
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final currentUserPhoto = FirebaseAuth.instance.currentUser?.photoURL;
    return Padding(
      // Keep the sheet above the keyboard.
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ModalHeader(title: 'New Chat'),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: AnimatedAvatarStack(
                height: 60,
                avatars: [
                  // The current user's photo is always shown.
                  if (currentUserPhoto != null)
                    CachedNetworkImageProvider(currentUserPhoto),
                  for (final user in _selectedUsers)
                    CachedNetworkImageProvider(user.photoUrl),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Search for a user',
                  border: const OutlineInputBorder(),
                  hintText: 'Enter username',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.person_add_alt),
                    onPressed: _addUser,
                  ),
                ),
              ),
            ),
            // A group needs a name.
            SizeSwitcher(
              child: _selectedUsers.length <= 1
                  ? const SizedBox.shrink(key: ValueKey('empty'))
                  : Padding(
                      key: const ValueKey('groupName'),
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: _groupNameController,
                          decoration: const InputDecoration(
                            labelText: 'Enter a group name*',
                            border: OutlineInputBorder(),
                          ),
                          validator: validateGroupName,
                        ),
                      ),
                    ),
            ),
            const SizedBox(height: 16),
            SizeSwitcher(
              child: _selectedUsers.isEmpty
                  ? const SizedBox.shrink(key: ValueKey('empty'))
                  : Padding(
                      key: const ValueKey('button'),
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: FilledButton(
                        onPressed: _submitting ? null : _createChat,
                        style: FilledButton.styleFrom(
                          minimumSize: const Size.fromHeight(48),
                        ),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder: (child, animation) =>
                              ScaleTransition(scale: animation, child: child),
                          child: _selectedUsers.length == 1
                              ? const Text('Create DM', key: ValueKey('single'))
                              : const Text(
                                  'Create Group Chat',
                                  key: ValueKey('group'),
                                ),
                        ),
                      ),
                    ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
