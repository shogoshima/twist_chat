import 'package:flutter/material.dart';

/// Asks the user to confirm an action. Completes with `true` only when they
/// tap Confirm.
Future<bool> showConfirmDialog(
  BuildContext context,
  String title,
  String content,
) async {
  final confirmed = await showDialog<bool>(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          TextButton(
            child: const Text('Confirm'),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      );
    },
  );
  return confirmed ?? false;
}
