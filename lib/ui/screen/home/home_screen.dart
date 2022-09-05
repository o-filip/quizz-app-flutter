import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../localization/l10n.dart';
import '../../navigation/route/stored_questions_list_route.dart';
import '../../widget/screen_horizontal_padding.dart';
import 'widget/home_new_quiz_section.dart';
import 'widget/home_random_question_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: _buildScrollContent(context),
        ),
      ),
    );
  }

  Column _buildScrollContent(BuildContext context) {
    return Column(
      children: [
        const HomeNewQuizSection(),
        ScreenHorizontalPadding.symmetricVertical(
          verticalPadding: 16,
          child: ElevatedButton(
            onPressed: () {
              context.go(StoredQuestionsListGoRoute.route());
            },
            child: Text(S.of(context).home_all_stored_questions_button),
          ),
        ),
        const HomeRandomQuestionSection(),
      ],
    );
  }
}
