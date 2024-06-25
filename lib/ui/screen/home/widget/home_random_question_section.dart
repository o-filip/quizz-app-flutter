import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/entity/question.dart';
import '../../../bloc/random_question/random_question_bloc.dart';
import '../../../bloc/random_question/random_question_bloc_event.dart';
import '../../../bloc/random_question/random_question_state.dart';
import '../../../error/ui_error_converter.dart';
import '../../../utils/dimensions.dart';
import '../../../widget/practice_question_widget.dart';
import '../../../widget/screen_horizontal_padding.dart';

class HomeRandomQuestionSection extends StatelessWidget {
  const HomeRandomQuestionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: BlocBuilder<RandomQuestionBloc, RandomQuestionState>(
        builder: (context, state) => Column(
          children: [
            _buildHeader(context),
            _buildBody(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return BlocBuilder<RandomQuestionBloc, RandomQuestionState>(
        builder: (context, state) {
      return ScreenHorizontalPadding.symmetricVertical(
        verticalPadding: Dimensions.vertSpacingSmall,
        child: Row(
          children: [
            Text(
              S.of(context).random_question_section_header,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            IconButton(
              onPressed: () {
                context
                    .read<RandomQuestionBloc>()
                    .add(const LoadRandomQuestionEvent());
              },
              icon: switch (state) {
                RandomQuestionStateLoading _ =>
                  const CircularProgressIndicator(),
                _ => Icon(
                    Icons.refresh,
                    color: Theme.of(context).colorScheme.primary,
                  ),
              },
            ),
          ],
        ),
      );
    });
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<RandomQuestionBloc, RandomQuestionState>(
      builder: (context, state) {
        return switch (state) {
          final RandomQuestionStateData data => PracticeQuestionWidget(
              question: data.question,
            ),
          final RandomQuestionStateLoading loading => _buildLoading(
              context,
              loading.question,
            ),
          final RandomQuestionStateError error => _buildError(
              context,
              error.error,
            ),
          _ => Container(),
        };
      },
    );
  }

  Widget _buildLoading(
    BuildContext context,
    Question? question,
  ) {
    return question != null
        ? PracticeQuestionWidget(question: question)
        : Container();
  }

  Widget _buildError(
    BuildContext context,
    dynamic error,
  ) {
    return ScreenHorizontalPadding.symmetricVertical(
      verticalPadding: Dimensions.vertSpacingLarge,
      child: Text(
        UiErrorConverter.convert(context, error),
        style: Theme.of(context).textTheme.bodyLarge,
        textAlign: TextAlign.center,
      ),
    );
  }
}
