import 'package:flutter/material.dart';

class AnimatedFloatingButton extends StatelessWidget {
  const AnimatedFloatingButton({
    super.key,
    required this.isHidden,
    this.onPressed,
    this.child,
  });

  final bool isHidden;
  final VoidCallback? onPressed;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: child,
      ),
      child: isHidden
          ? const SizedBox.shrink()
          : FloatingActionButton(
              onPressed: onPressed,
              child: child,
            ),
    );
  }
}
