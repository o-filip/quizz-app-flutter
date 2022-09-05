import 'package:flutter/material.dart';

import '../../../bloc/quiz/quiz_bloc_state.dart';
import 'quiz_review_answers_list_section.dart';
import 'quiz_review_overview_section.dart';

class QuizReviewContent extends StatelessWidget {
  const QuizReviewContent({
    super.key,
    required this.state,
  });

  final QuizFinished state;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        QuizReviewOverviewSection(state: state),
        QuizReviewAnswersListSection(state: state),
      ],
    );
  }
}
