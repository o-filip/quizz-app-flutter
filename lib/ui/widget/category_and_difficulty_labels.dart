import 'package:flutter/material.dart';

import '../../core/entity/question.dart';

class CategoryAndDifficultyLabels extends StatelessWidget {
  const CategoryAndDifficultyLabels({
    super.key,
    required this.question,
  });

  final Question question;

  @override
  Widget build(BuildContext context) {
    return Text(
      '${question.category.toUserString(context)} • ${question.difficulty.toUserString(context)}',
      style: Theme.of(context).textTheme.labelLarge,
    );
  }
}
