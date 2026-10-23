import 'package:flutter/material.dart';

/// An [AnimatedSwitcher] that grows or shrinks vertically to the new child.
///
/// Give children distinct keys so the switch is detected.
class SizeSwitcher extends StatelessWidget {
  const SizeSwitcher({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return SizeTransition(
          sizeFactor: animation,
          alignment: AlignmentDirectional.topStart,
          child: child,
        );
      },
      child: child,
    );
  }
}
