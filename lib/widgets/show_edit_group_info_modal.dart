import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twist_chat/common/validators.dart';
import 'package:twist_chat/providers/global_chat.dart';
import 'package:twist_chat/widgets/modal_header.dart';
import 'package:twist_chat/widgets/size_switcher.dart';

Future<void> showEditGroupInfoModal(
  BuildContext context,
  String chatId,
  String groupName,
) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) =>
        _EditGroupInfoSheet(chatId: chatId, groupName: groupName),
  );
}

class _EditGroupInfoSheet extends ConsumerStatefulWidget {
  const _EditGroupInfoSheet({required this.chatId, required this.groupName});

  final String chatId;
  final String groupName;

  @override
  ConsumerState<_EditGroupInfoSheet> createState() =>
      _EditGroupInfoSheetState();
}

class _EditGroupInfoSheetState extends ConsumerState<_EditGroupInfoSheet> {
  final _formKey = GlobalKey<FormState>();
  late final _groupNameController = TextEditingController(
    text: widget.groupName,
  );
  bool _submitting = false;

  @override
  void dispose() {
    _groupNameController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _submitting = true);
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref
          .read(globalChatProvider.notifier)
          .updateGroupChatInfo(widget.chatId, _groupNameController.text);
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
            const ModalHeader(title: 'Edit Group Info'),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Form(
                key: _formKey,
                child: TextFormField(
                  controller: _groupNameController,
                  decoration: const InputDecoration(
                    labelText: 'Edit your group name*',
                    border: OutlineInputBorder(),
                  ),
                  validator: validateGroupName,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Rebuilds as the user types, hiding the button while empty.
            ValueListenableBuilder(
              valueListenable: _groupNameController,
              builder: (context, value, child) => SizeSwitcher(
                child: value.text.isEmpty
                    ? const SizedBox.shrink(key: ValueKey('empty'))
                    : Padding(
                        key: const ValueKey('button'),
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: FilledButton(
                          onPressed: _submitting ? null : _save,
                          style: FilledButton.styleFrom(
                            minimumSize: const Size.fromHeight(48),
                          ),
                          child: const Text('Save'),
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
