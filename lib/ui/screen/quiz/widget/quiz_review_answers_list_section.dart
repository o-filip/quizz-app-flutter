import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/entity/question.dart';
import '../../../bloc/quiz/quiz_bloc_state.dart';
import '../../../theme/extensions/colors_extension_theme_data.dart';
import '../../../utils/dimensions.dart';
import '../../../widget/question_like_button.dart';

class QuizReviewAnswersListSection extends StatelessWidget {
  const QuizReviewAnswersListSection({
    super.key,
    required this.state,
  });

  final QuizFinished state;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Dimensions.vertSpacingMedium,
            ),
            child: Text(
              S.of(context).quiz_review_content_your_answers_header,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          ..._buildAnswers(context),
        ],
      ),
    );
  }

  List<Widget> _buildAnswers(BuildContext context) {
    return state.questions
        .map((question) => _buildAnswerListItem(context, question))
        .toList();
  }

  Widget _buildAnswerListItem(
    BuildContext context,
    Question question,
  ) {
    final selectedAnswer = state.selectedAnswers[question.id];
    final correctAnswer = question.answers.firstWhere(
      (answer) => answer.isCorrect,
    );

    final questionAndAnswersColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question.question,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Text(
          '${S.of(context).quiz_review_content_your_answer}: ${selectedAnswer?.text}',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        if (selectedAnswer != correctAnswer)
          Text(
            '${S.of(context).quiz_review_content_correct_answer}: ${correctAnswer.text}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
      ],
    );

    final likeAndFlagColumn = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        QuestionLikeButton(question: question),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            selectedAnswer == correctAnswer ? Icons.check_circle : Icons.cancel,
            color: selectedAnswer == correctAnswer
                ? Theme.of(context)
                    .extension<ColorsExtensionThemeData>()
                    ?.correctAnswer
                : Theme.of(context)
                    .extension<ColorsExtensionThemeData>()
                    ?.incorrectAnswer,
          ),
        ),
      ],
    );

    return Card(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 16,
          top: 16,
          bottom: 16,
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: questionAndAnswersColumn,
              ),
              likeAndFlagColumn
            ],
          ),
        ),
      ),
    );
  }
}
