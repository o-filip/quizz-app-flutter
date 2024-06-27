import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/extension/result_ext.dart';
import '../../../domain/use_case/toggle_question_like_use_case.dart';
import 'toggle_question_like_state.dart';

class ToggleQuestionLikeCubit extends Cubit<ToggleQuestionLikeState> {
  ToggleQuestionLikeCubit({
    required this.toggleQuestionLikeUseCase,
  }) : super(const ToggleQuestionLikeStateInitial());

  final ToggleQuestionLikeUseCase toggleQuestionLikeUseCase;

  void toggleQuestionLike(String questionId) {
    emit(const ToggleQuestionLikeStateToggleInProgress());

    toggleQuestionLikeUseCase(questionId).then(
      (result) => result.when(
        value: (_) => emit(const ToggleQuestionLikeStateDone()),
        error: (error) => emit(ToggleQuestionLikeStateError(error: error)),
      ),
    );
  }
}
