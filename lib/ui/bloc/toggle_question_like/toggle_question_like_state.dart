import 'package:freezed_annotation/freezed_annotation.dart';

part 'toggle_question_like_state.freezed.dart';

sealed class ToggleQuestionLikeState {
  const ToggleQuestionLikeState();
}

class ToggleQuestionLikeStateInitial extends ToggleQuestionLikeState {
  const ToggleQuestionLikeStateInitial();
}

class ToggleQuestionLikeStateToggleInProgress extends ToggleQuestionLikeState {
  const ToggleQuestionLikeStateToggleInProgress();
}

class ToggleQuestionLikeStateDone extends ToggleQuestionLikeState {
  const ToggleQuestionLikeStateDone();
}

@freezed
class ToggleQuestionLikeStateError extends ToggleQuestionLikeState
    with _$ToggleQuestionLikeStateError {
  factory ToggleQuestionLikeStateError({
    required dynamic error,
  }) = _ToggleQuestionLikeStateError;
}
