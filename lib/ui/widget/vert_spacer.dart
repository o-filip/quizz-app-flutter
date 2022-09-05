import 'package:flutter/material.dart';

import '../utils/dimensions.dart';

class VerticalSpacer extends StatelessWidget {
  const VerticalSpacer({
    super.key,
    required this.size,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: size);
  }
}

class VertSpacerSmall extends StatelessWidget {
  const VertSpacerSmall({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const VerticalSpacer(size: Dimensions.vertSpacingSmall);
  }
}

class VerticalSpacerMedium extends StatelessWidget {
  const VerticalSpacerMedium({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const VerticalSpacer(size: Dimensions.vertSpacingMedium);
  }
}

class VerticalSpacerLarge extends StatelessWidget {
  const VerticalSpacerLarge({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const VerticalSpacer(size: Dimensions.vertSpacingLarge);
  }
}

class VerticalSpacerXLarge extends StatelessWidget {
  const VerticalSpacerXLarge({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const VerticalSpacer(size: Dimensions.vertSpacingXLarge);
  }
}
