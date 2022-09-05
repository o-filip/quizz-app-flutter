import 'package:flutter/widgets.dart';

import '../../localization/l10n.dart';

enum Difficulty {
  easy,
  medium,
  hard;

  String toUserString(BuildContext context) {
    switch (this) {
      case Difficulty.easy:
        return S.of(context).difficult_easy;
      case Difficulty.medium:
        return S.of(context).difficult_medium;
      case Difficulty.hard:
        return S.of(context).difficult_hard;
    }
  }
}
