import 'package:flutter/material.dart';

import '../../core/entity/answer.dart';
import '../theme/extensions/colors_extension_theme_data.dart';

class AnswerDisplay extends StatelessWidget {
  const AnswerDisplay({
    super.key,
    required this.answer,
    required this.highlightCorrect,
  });

  final Answer answer;
  final bool highlightCorrect;

  @override
  Widget build(BuildContext context) {
    BoxDecoration boxDecoration;
    Color textColor;

    if (highlightCorrect && answer.isCorrect) {
      boxDecoration = BoxDecoration(
        color: Theme.of(context)
            .extension<ColorsExtensionThemeData>()!
            .correctAnswer,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context)
              .extension<ColorsExtensionThemeData>()!
              .correctAnswer!,
        ),
      );
      textColor = Theme.of(context)
          .extension<ColorsExtensionThemeData>()!
          .onCorrectAnswer!;
    } else {
      boxDecoration = BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(),
      );
      textColor = Theme.of(context).colorScheme.onSurface;
    }

    return Container(
      decoration: boxDecoration,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4,
      ),
      child: Text(
        answer.text,
        style:
            Theme.of(context).textTheme.bodyLarge?.copyWith(color: textColor),
      ),
    );
  }
}
