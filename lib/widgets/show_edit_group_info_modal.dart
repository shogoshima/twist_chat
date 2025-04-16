import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twist_chat/providers/global_chat.dart';

Future<void> showEditGroupInfoModal(
  BuildContext context,
  WidgetRef ref,
  String chatId,
  String groupName,
) {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController groupNameController = TextEditingController(
    text: groupName,
  );

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
            // Adjust for keyboard
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildHeader(context),
                  _buildGroupNameForm(formKey, groupNameController),
                  SizedBox(height: 16),
                  _buildSaveButton(
                    context,
                    ref,
                    chatId,
                    formKey,
                    groupNameController,
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

/// Builds the modal header with the title and a close button.
Widget _buildHeader(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SizedBox(width: 48), // to balance the close button
      Text(
        'Edit Group Info',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () => Navigator.of(context).pop(),
      ),
    ],
  );
}

/// Builds the form containing a TextFormField for editing group name.
Widget _buildGroupNameForm(
  GlobalKey<FormState> formKey,
  TextEditingController controller,
) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
    child: Form(
      key: formKey,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: 'Edit your group name*',
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
  );
}

/// Builds the save button with an AnimatedSwitcher that changes if the field is empty.
Widget _buildSaveButton(
  BuildContext context,
  WidgetRef ref,
  String chatId,
  GlobalKey<FormState> formKey,
  TextEditingController controller,
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
        controller.text.isEmpty
            ? SizedBox(key: ValueKey('empty'))
            : Padding(
              key: ValueKey('button'),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: FilledButton(
                onPressed: () {
                  try {
                    if (formKey.currentState!.validate()) {
                      ref
                          .read(globalChatProvider.notifier)
                          .updateGroupChatInfo(chatId, controller.text);

                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
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
                child: Text('Save'),
              ),
            ),
  );
}
