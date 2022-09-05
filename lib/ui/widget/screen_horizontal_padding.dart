import 'package:flutter/material.dart';

import '../utils/dimensions.dart';

class ScreenHorizontalPadding extends StatelessWidget {
  const ScreenHorizontalPadding({
    super.key,
    required this.child,
    this.paddingTop = 0,
    this.paddingBottom = 0,
  });

  factory ScreenHorizontalPadding.symmetricVertical({
    required Widget child,
    double verticalPadding = 0,
  }) =>
      ScreenHorizontalPadding(
        paddingTop: verticalPadding,
        paddingBottom: verticalPadding,
        child: child,
      );

  final Widget child;
  final double paddingTop;
  final double paddingBottom;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(
          top: paddingTop,
          bottom: paddingBottom,
          left: Dimensions.horScreenPadding,
          right: Dimensions.horScreenPadding,
        ),
        child: child,
      );
}
