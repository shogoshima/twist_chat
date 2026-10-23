import 'dart:developer';

import 'package:avatar_stack/animated_avatar_stack.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twist_chat/models/models.dart';
import 'package:twist_chat/providers/search_user.dart';
import 'package:twist_chat/providers/single_chat.dart';
import 'package:twist_chat/widgets/modal_header.dart';
import 'package:twist_chat/widgets/size_switcher.dart';

Future<void> showAddUserModal(
  BuildContext context,
  String chatId,
  List<Profile> presentParticipants,
) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) =>
        _AddUserSheet(chatId: chatId, presentParticipants: presentParticipants),
  );
}

class _AddUserSheet extends ConsumerStatefulWidget {
  const _AddUserSheet({
    required this.chatId,
    required this.presentParticipants,
  });

  final String chatId;
  final List<Profile> presentParticipants;

  @override
  ConsumerState<_AddUserSheet> createState() => _AddUserSheetState();
}

class _AddUserSheetState extends ConsumerState<_AddUserSheet> {
  final _usernameController = TextEditingController();
  final List<Profile> _selectedUsers = [];
  bool _submitting = false;

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  Future<void> _addUser() async {
    final username = _usernameController.text.trim();
    if (username.isEmpty) return;

    try {
      final user = await ref.read(searchUserProvider(username).future);
      if (user == null || !mounted) return;
      // Only add if not already in the chat or in the list.
      if (widget.presentParticipants.contains(user) ||
          _selectedUsers.contains(user)) {
        return;
      }
      setState(() => _selectedUsers.add(user));
      _usernameController.clear();
    } catch (error) {
      log(error.toString());
    }
  }

  Future<void> _addParticipants() async {
    setState(() => _submitting = true);
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref
          .read(singleChatProvider(widget.chatId).notifier)
          .addParticipants(_selectedUsers.map((e) => e.username).toList());
    } catch (error) {
      messenger.showSnackBar(SnackBar(content: Text('Error: $error')));
      if (mounted) Navigator.of(context).pop();
      return;
    }
    if (!mounted) return;
    // Close this sheet and the group sheet beneath it.
    Navigator.of(context)
      ..pop()
      ..pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Keep the sheet above the keyboard.
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ModalHeader(title: 'Add More Participants'),
            const SizedBox(height: 16),
            SizeSwitcher(
              child: _selectedUsers.isEmpty
                  ? const SizedBox.shrink(key: ValueKey('empty'))
                  : Padding(
                      key: const ValueKey('participants'),
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: AnimatedAvatarStack(
                        height: 60,
                        avatars: [
                          for (final user in _selectedUsers)
                            CachedNetworkImageProvider(user.photoUrl),
                        ],
                      ),
                    ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Add participants',
                  border: const OutlineInputBorder(),
                  hintText: 'Enter username',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.person_add_alt),
                    onPressed: _addUser,
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
                        onPressed: _submitting ? null : _addParticipants,
                        style: FilledButton.styleFrom(
                          minimumSize: const Size.fromHeight(48),
                        ),
                        child: const Text('Add participants'),
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
