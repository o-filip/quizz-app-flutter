import 'package:flutter/material.dart';

/// A widget that animates the transition between two children using a slide
/// and scale animation.
///
/// The [pageIndex] parameter is used to determine which child is currently
/// being displayed. The child with the key [ValueKey<int>(pageIndex)] will
/// be displayed with a slide in from right and scale animation, while the other child
/// will be displayed with a slide out to left and scale animation.
class AnimatedSlideInSwitcher extends StatelessWidget {
  const AnimatedSlideInSwitcher({
    super.key,
    required this.child,
    required this.pageIndex,
  });

  final Widget child;
  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      layoutBuilder: (currentChild, previousChildren) => Stack(
        alignment: Alignment.topCenter,
        children: [
          ...previousChildren,
          if (currentChild != null) currentChild,
        ],
      ),
      transitionBuilder: (child, animation) {
        if (pageIndex == 0) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        }

        final slideInAnimation = Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(animation);

        final slideOutAnimation = Tween<Offset>(
          begin: const Offset(-1, 0),
          end: Offset.zero,
        ).animate(animation);

        final scaleAnimation = Tween<double>(
          begin: 0.8,
          end: 1.0,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        ));

        return ScaleTransition(
          scale: scaleAnimation,
          child: SlideTransition(
            position: child.key == ValueKey<int>(pageIndex)
                ? slideInAnimation
                : slideOutAnimation,
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
