import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/entity/answer.dart';
import '../../../../localization/l10n.dart';
import '../../../bloc/quiz/quiz_bloc.dart';
import '../../../bloc/quiz/quiz_bloc_event.dart';
import '../../../bloc/quiz/quiz_bloc_state.dart';
import '../../../utils/dimensions.dart';
import '../../../widget/category_and_difficulty_labels.dart';
import '../../../widget/screen_horizontal_padding.dart';
import '../../../widget/vert_spacer.dart';

class QuizQuestionContent extends StatefulWidget {
  const QuizQuestionContent({
    super.key,
    required this.state,
  });

  final DisplayingQuestion state;

  @override
  State<StatefulWidget> createState() => QuizQuestionContentState();
}

class QuizQuestionContentState extends State<QuizQuestionContent> {
  Answer? _selectedAnswer;

  @override
  void didUpdateWidget(covariant QuizQuestionContent oldWidget) {
    if (oldWidget.state != widget.state) {
      // Reset selected answer when new question is displayed
      setState(() {
        _selectedAnswer = null;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildProgressAndQuestion(context),
            _buildAnswersAnNextButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressAndQuestion(BuildContext context) {
    return ScreenHorizontalPadding.symmetricVertical(
      verticalPadding: Dimensions.vertSpacingLarge,
      child: Column(
        children: [
          Text(
            S.of(context).quiz_question_content_progress(
                widget.state.currentQuestionIndex + 1,
                widget.state.questions.length),
            style: Theme.of(context).textTheme.labelLarge,
          ),
          LinearProgressIndicator(
            value: (widget.state.currentQuestionIndex + 1) /
                widget.state.questions.length,
          ),
          const VerticalSpacerXLarge(),
          CategoryAndDifficultyLabels(
            question: widget.state.currentQuestion,
          ),
          const VerticalSpacerMedium(),
          Text(
            widget.state.currentQuestion.question,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAnswersAnNextButton(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: Column(
        children: [
          ...widget.state.currentQuestion.answers.map(
            (answer) => RadioListTile<Answer>(
              title: Text(answer.text),
              value: answer,
              groupValue: _selectedAnswer,
              onChanged: (value) {
                setState(() {
                  _selectedAnswer = value;
                });
              },
            ),
          ),
          ScreenHorizontalPadding.symmetricVertical(
            verticalPadding: 8,
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed:
                    _selectedAnswer != null ? () => _onNextTap(context) : null,
                child: Text(S.of(context).quiz_question_content_confirm_button),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onNextTap(BuildContext context) {
    if (_selectedAnswer != null) {
      context.read<QuizBloc>().add(
            AnswerQuestionEvent(
              question: widget.state.currentQuestion,
              answer: _selectedAnswer!,
            ),
          );
    }
  }
}
