import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/di/di.dart';
import '../../../core/enum/category.dart';
import '../../../core/enum/difficulty.dart';
import '../../bloc/quiz/quiz_bloc.dart';
import '../../bloc/quiz/quiz_bloc_event.dart';
import '../../bloc/quiz/quiz_state.dart';
import '../../error/ui_error_converter.dart';
import '../../navigation/query_params_ext.dart';
import '../../utils/dimensions.dart';
import '../../widget/screen_horizontal_padding.dart';
import '../../widget/vert_spacer.dart';
import 'widget/quiz_question_content.dart';
import 'widget/quiz_review_content.dart';

class QuizRoute {
  static const path = '/quiz';

  static Uri uri({
    Difficulty? difficulty,
    List<Category>? categories,
    required int numOfQuestions,
  }) =>
      Uri(
        path: path,
        queryParameters: {
          if (difficulty != null) 'difficulty': difficulty.index.toString(),
          if (categories?.isNotEmpty ?? false)
            'categories': categories!.encodeEnumListToUriQuery(),
          'numOfQuestions': numOfQuestions.toString(),
        },
      );

  static QuizScreen fromUri(Uri uri) {
    final difficulty = uri.queryParameters['difficulty'] != null
        ? Difficulty.values[int.parse(uri.queryParameters['difficulty']!)]
        : null;
    final categories = uri.decodeEnumList('categories', Category.values) ?? [];
    final numOfQuestions = int.parse(uri.queryParameters['numOfQuestions']!);

    return QuizScreen(
      difficulty: difficulty,
      categories: categories,
      numOfQuestions: numOfQuestions,
    );
  }
}

class QuizScreen extends StatelessWidget {
  const QuizScreen({
    super.key,
    this.difficulty,
    required this.categories,
    required this.numOfQuestions,
  });

  final Difficulty? difficulty;
  final List<Category> categories;
  final int numOfQuestions;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<QuizBloc>(
      create: (_) => getIt<QuizBloc>()
        ..add(
          GenerateQuizEvent(
            difficulty: difficulty,
            categories: categories,
            numOfQuestions: numOfQuestions,
          ),
        ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).quiz_app_bar_title),
        ),
        body: SafeArea(
          child: _buildBody(context),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<QuizBloc, QuizState>(
      builder: (context, state) {
        if (state is QuizStateInitial) {
          return Container();
        } else if (state is QuizStateLoading) {
          return _buildLoading(context);
        } else if (state is QuizStateDisplayingQuestion) {
          return QuizQuestionContent(state: state);
        } else if (state is QuizStateError) {
          return _buildError(context, state);
        } else if (state is QuizStateFinished) {
          return QuizReviewContent(state: state);
        } else {
          throw UnimplementedError();
        }
      },
    );
  }

  Widget _buildLoading(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(S.of(context).quiz_loading_message,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  )),
          const VerticalSpacerMedium(),
          const CircularProgressIndicator(),
        ],
      ),
    );
  }

  Widget _buildError(
    BuildContext context,
    QuizStateError state,
  ) {
    return Center(
      child: ScreenHorizontalPadding.symmetricVertical(
        verticalPadding: Dimensions.vertSpacingXLarge,
        child: Text(
          UiErrorConverter.convert(context, state.error),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
