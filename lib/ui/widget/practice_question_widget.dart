import 'package:flutter/material.dart';

import '../../core/entity/question.dart';
import '../../localization/l10n.dart';
import 'answer_display.dart';
import 'category_and_difficulty_labels.dart';
import 'question_like_button.dart';

class PracticeQuestionWidget extends StatefulWidget {
  const PracticeQuestionWidget({
    super.key,
    required this.question,
  });

  final Question question;

  @override
  State<StatefulWidget> createState() => PracticeQuestionWidgetState();
}

class PracticeQuestionWidgetState extends State<PracticeQuestionWidget> {
  bool _isCorrectAnswerVisible = false;

  @override
  void didUpdateWidget(covariant PracticeQuestionWidget oldWidget) {
    if (oldWidget.question != widget.question) {
      setState(() {
        _isCorrectAnswerVisible = false;
      });
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CategoryAndDifficultyLabels(question: widget.question),
                ),
                QuestionLikeButton(question: widget.question),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 22),
              child: Text(
                widget.question.question,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: widget.question.answers
                  .map((e) => AnswerDisplay(
                        answer: e,
                        highlightCorrect: _isCorrectAnswerVisible,
                      ))
                  .toList(),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _onShowCorrectAnswerToggle,
              child: Text(
                _isCorrectAnswerVisible
                    ? S.of(context).practice_question_hide_correct_answer
                    : S.of(context).practice_question_show_correct_answer,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onShowCorrectAnswerToggle() {
    setState(() {
      _isCorrectAnswerVisible = !_isCorrectAnswerVisible;
    });
  }
}
