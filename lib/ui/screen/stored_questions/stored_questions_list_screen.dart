import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/entity/question.dart';
import '../../../localization/l10n.dart';
import '../../bloc/stored_questions/filter/stored_questions_filter_cubit.dart';
import '../../bloc/stored_questions/filter/stored_questions_filter_cubit_state.dart';
import '../../bloc/stored_questions/list/stored_questions_list_bloc.dart';
import '../../bloc/stored_questions/list/stored_questions_list_bloc_state.dart';
import '../../error/ui_error_converter.dart';
import '../../utils/dimensions.dart';
import '../../widget/screen_horizontal_padding.dart';
import 'widget/stored_question_list_item.dart';

@RoutePage()
class StoredQuestionsListScreen extends StatelessWidget {
  const StoredQuestionsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).stored_questions_app_bar_title),
      ),
      body: SafeArea(
          child: Column(
        children: [
          _buildFilter(context),
          _buildContent(context),
        ],
      )),
    );
  }

  Widget _buildFilter(BuildContext context) {
    return BlocBuilder<StoredQuestionsFilterCubit,
        StoredQuestionsFilterCubitState>(
      builder: (context, state) {
        return CheckboxListTile(
          value: state.likedOnly,
          onChanged: (value) {
            context.read<StoredQuestionsFilterCubit>().toggleLikedOnly();
          },
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(
            S.of(context).stored_questions_filter_liked_only,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
          ),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context) {
    return BlocBuilder<StoredQuestionsListBloc, StoredQuestionsListBlocState>(
      builder: (context, state) => state.map(
        initial: (_) => Container(),
        loading: (loading) => loading.questions != null
            ? _buildQuestionsList(context, loading.questions!)
            : _buildLoadingIndicator(),
        loaded: (loaded) => loaded.questions.isEmpty
            ? _buildEmptyListMessage(context)
            : _buildQuestionsList(context, loaded.questions),
        error: (error) => _buildErrorMessage(context, error.error),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildQuestionsList(BuildContext context, List<Question> questions) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) => StoredQuestionListItem(
          key: Key(questions[index].id),
          question: questions[index],
        ),
        itemCount: questions.length,
      ),
    );
  }

  Widget _buildEmptyListMessage(BuildContext context) {
    return ScreenHorizontalPadding.symmetricVertical(
      verticalPadding: Dimensions.vertSpacingLarge,
      child: Center(
        child: Text(
          S.of(context).error_domain_no_stored_question,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
        ),
      ),
    );
  }

  Widget _buildErrorMessage(BuildContext context, Object error) {
    return Center(
      child: Text(
        UiErrorConverter.convert(context, error),
      ),
    );
  }
}
