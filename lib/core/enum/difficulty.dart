import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum Difficulty {
  easy,
  medium,
  hard;

  String toUserString(BuildContext context) => switch (this) {
        Difficulty.easy => S.of(context).difficult_easy,
        Difficulty.medium => S.of(context).difficult_medium,
        Difficulty.hard => S.of(context).difficult_hard,
      };
}
