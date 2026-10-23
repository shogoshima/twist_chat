import 'package:flutter/material.dart';

/// Title row for bottom sheets: a centered title and a close button.
class ModalHeader extends StatelessWidget {
  const ModalHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Balances the close button so the title stays centered.
        const SizedBox(width: 48),
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
