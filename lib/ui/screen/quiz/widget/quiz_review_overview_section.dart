import 'package:flutter/material.dart';

import '../../../../localization/l10n.dart';
import '../../../bloc/quiz/quiz_bloc_state.dart';
import '../../../utils/dimensions.dart';
import '../../../widget/screen_horizontal_padding.dart';
import '../../../widget/vert_spacer.dart';

class QuizReviewOverviewSection extends StatelessWidget {
  const QuizReviewOverviewSection({
    super.key,
    required this.state,
  });

  final QuizFinished state;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ScreenHorizontalPadding.symmetricVertical(
        verticalPadding: Dimensions.vertSpacingMedium,
        child: Column(
          children: [
            Text(
              S.of(context).quiz_review_content_header,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const VertSpacerSmall(),
            _buildDifficultyLabel(context),
            _buildCategoriesLabel(context),
            const VerticalSpacerMedium(),
            _buildProgress(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDifficultyLabel(BuildContext context) {
    final difficulty = state.difficulty != null
        ? state.difficulty!.toUserString(context)
        : S.of(context).difficult_any;
    return Text(
      '${S.of(context).quiz_review_content_difficulty}: $difficulty',
      style: Theme.of(context).textTheme.labelLarge,
    );
  }

  Widget _buildCategoriesLabel(BuildContext context) {
    final categories = state.categories.isEmpty
        ? S.of(context).category_any
        : state.categories
            .map((category) => category.toUserString(context))
            .join(', ');
    return Text(
      '${S.of(context).quiz_review_content_categories}: $categories',
      style: Theme.of(context).textTheme.labelLarge,
    );
  }

  Widget _buildProgress(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 150,
          height: 150,
          child: CircularProgressIndicator(
            value: state.correctAnswersCount / state.questions.length,
            strokeWidth: 8,
          ),
        ),
        Column(
          children: [
            Text(
              '${state.correctAnswersCount}/${state.questions.length}',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(
              S.of(context).quiz_review_content_correct_answers,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
      ],
    );
  }
}
