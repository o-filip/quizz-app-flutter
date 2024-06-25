import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../navigation/app_router.dart';
import '../../widget/screen_horizontal_padding.dart';
import 'widget/home_new_quiz_section.dart';
import 'widget/home_random_question_section.dart';

@RoutePage()
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
              context.pushRoute(const StoredQuestionsListRoute());
            },
            child: Text(S.of(context).home_all_stored_questions_button),
          ),
        ),
        const HomeRandomQuestionSection(),
      ],
    );
  }
}
