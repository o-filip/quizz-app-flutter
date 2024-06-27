import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../bloc/quiz/quiz_state.dart';
import '../../../utils/dimensions.dart';
import '../../../widget/screen_horizontal_padding.dart';
import '../../../widget/vert_spacer.dart';

class QuizReviewOverviewSection extends StatelessWidget {
  const QuizReviewOverviewSection({
    super.key,
    required this.state,
  });

  final QuizStateFinished state;

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
            AnimatedQuizReviewProgress(state: state)
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
}

class AnimatedQuizReviewProgress extends StatefulWidget {
  const AnimatedQuizReviewProgress({
    super.key,
    required this.state,
  });

  final QuizStateFinished state;

  @override
  State<AnimatedQuizReviewProgress> createState() =>
      _AnimatedQuizReviewProgressState();
}

class _AnimatedQuizReviewProgressState extends State<AnimatedQuizReviewProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _animation = Tween<double>(
      begin: 0,
      end: widget.state.correctAnswersCount / widget.state.questions.length,
    ).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 150,
          height: 150,
          child: CircularProgressIndicator(
            value: _animation.value,
            strokeWidth: 8,
          ),
        ),
        Column(
          children: [
            Text(
              '${widget.state.correctAnswersCount}/${widget.state.questions.length}',
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
