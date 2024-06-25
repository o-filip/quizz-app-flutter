import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/enum/category.dart';
import '../../../../core/enum/difficulty.dart';
import '../../../navigation/app_router.dart';
import '../../../utils/dimensions.dart';
import '../../../widget/categories_selection_input.dart';
import '../../../widget/difficulty_dropdown_button.dart';
import '../../../widget/screen_horizontal_padding.dart';
import '../../../widget/vert_spacer.dart';

class HomeNewQuizSection extends StatefulWidget {
  const HomeNewQuizSection({super.key});

  @override
  State<StatefulWidget> createState() => HomeNewQuizSectionState();
}

class HomeNewQuizSectionState extends State<HomeNewQuizSection> {
  Difficulty? _difficulty;
  List<Category>? categories;
  int _numOfQuestions = 5;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ScreenHorizontalPadding.symmetricVertical(
        verticalPadding: Dimensions.vertSpacingSmall,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              S.of(context).new_quiz_section_header,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const VerticalSpacerLarge(),
            _buildDifficultySelection(context),
            const VerticalSpacerMedium(),
            _buildCategoriesSelection(context),
            const VerticalSpacerLarge(),
            _buildNumOfQuestionsSelection(context),
            const VerticalSpacerLarge(),
            FilledButton(
              onPressed: _onGenerateTap,
              child: Text(S.of(context).new_quiz_section_confirm_button),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDifficultySelection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).new_quiz_section_difficulty_label,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        DifficultyDropdownButton(
          onChanged: (value) {
            setState(() {
              _difficulty = value;
            });
          },
          value: _difficulty,
        ),
      ],
    );
  }

  Widget _buildCategoriesSelection(BuildContext context) {
    return CategoriesSelectionInput(
      value: categories,
      onChanged: (value) {
        setState(() {
          categories = value;
        });
      },
    );
  }

  Widget _buildNumOfQuestionsSelection(BuildContext context) {
    return Column(
      children: [
        Text(
          '${S.of(context).new_quiz_section_num_of_questions}: $_numOfQuestions',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        Slider(
          min: 1,
          max: 10,
          value: _numOfQuestions.toDouble(),
          onChanged: (value) => {
            setState(() {
              _numOfQuestions = value.toInt();
            }),
          },
        ),
      ],
    );
  }

  void _onGenerateTap() {
    context.pushRoute(QuizRoute(
      categories: categories ?? [],
      numOfQuestions: _numOfQuestions,
      difficulty: _difficulty,
    ));
  }
}
