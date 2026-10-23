import 'package:flutter/material.dart';

class FadingTextButton extends StatefulWidget {
  final String title;
  final String? content;
  final VoidCallback? onTap;
  final TextStyle? style;

  const FadingTextButton({
    super.key,
    required this.title,
    this.content,
    this.onTap,
    this.style,
  });

  @override
  State<FadingTextButton> createState() => _FadingTextButtonState();
}

class _FadingTextButtonState extends State<FadingTextButton> {
  bool _pressed = false;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _pressed = true;
    });
  }

  void _onTapUp(TapUpDetails details) {
    // Slight delay makes the animation feel smoother.
    Future.delayed(const Duration(milliseconds: 100), () {
      if (!mounted) return;
      setState(() {
        _pressed = false;
      });
      widget.onTap?.call();
    });
  }

  void _onTapCancel() {
    setState(() {
      _pressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTapDown: widget.onTap != null ? _onTapDown : null,
      onTapUp: widget.onTap != null ? _onTapUp : null,
      onTapCancel: widget.onTap != null ? _onTapCancel : null,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 100),
        opacity: _pressed ? 0.3 : 1.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: widget.style ?? Theme.of(context).textTheme.titleLarge,
              overflow: TextOverflow.ellipsis,
            ),
            if (widget.content case final content?)
              Text(
                content,
                style:
                    widget.style ??
                    TextStyle(
                      fontSize: 13,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
      ),
    );
  }
}
