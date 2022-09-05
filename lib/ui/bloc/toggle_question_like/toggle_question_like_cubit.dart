import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/extension/result_ext.dart';
import '../../../domain/use_case/toggle_question_like_use_case.dart';
import 'toggle_question_like_cubit_state.dart';

class ToggleQuestionLikeCubit extends Cubit<ToggleQuestionLikeCubitState> {
  ToggleQuestionLikeCubit({
    required this.toggleQuestionLikeUseCase,
  }) : super(const ToggleQuestionLikeCubitState.initial());

  final ToggleQuestionLikeUseCase toggleQuestionLikeUseCase;

  void toggleQuestionLike(String questionId) {
    emit(const ToggleQuestionLikeCubitState.toggleInProgress());

    toggleQuestionLikeUseCase(questionId).then(
      (result) => result.when(
        value: (_) => emit(const ToggleQuestionLikeCubitState.done()),
        error: (error) => emit(ToggleQuestionLikeCubitState.error(error)),
      ),
    );
  }
}
