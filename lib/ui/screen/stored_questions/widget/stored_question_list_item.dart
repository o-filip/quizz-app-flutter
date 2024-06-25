import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/entity/question.dart';
import '../../../widget/category_and_difficulty_labels.dart';
import '../../../widget/question_like_button.dart';

class StoredQuestionListItem extends StatefulWidget {
  const StoredQuestionListItem({
    super.key,
    required this.question,
  });

  final Question question;

  @override
  State<StatefulWidget> createState() => StoredQuestionListItemState();
}

class StoredQuestionListItemState extends State<StoredQuestionListItem>
    with AutomaticKeepAliveClientMixin {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Card(
      child: ExpansionTile(
        initiallyExpanded: _isExpanded,
        onExpansionChanged: (isExpanded) {
          setState(() {
            _isExpanded = isExpanded;
          });
        },
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  widget.question.question,
                ),
              ),
            ),
            QuestionLikeButton(
              question: widget.question,
            ),
          ],
        ),
        childrenPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 8,
        ),
        children: _buildAnswers(),
      ),
    );
  }

  List<Widget> _buildAnswers() {
    final correct = widget.question.answers.firstWhere((e) => e.isCorrect);

    final incorrect =
        widget.question.answers.where((e) => !e.isCorrect).toList();

    return [
      SizedBox(
        width: double.infinity,
        child: CategoryAndDifficultyLabels(question: widget.question),
      ),
      const Divider(),
      SizedBox(
        width: double.infinity,
        child: Text(
          '${S.of(context).stored_questions_correct}:',
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
      Text(
        correct.text,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      const Divider(),
      SizedBox(
        width: double.infinity,
        child: Text(
          '${S.of(context).stored_questions_incorrect}:',
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
      ...incorrect.map((e) => Text(
            e.text,
            style: Theme.of(context).textTheme.bodyLarge,
          )),
    ];
  }

  @override
  bool get wantKeepAlive => true;
}
