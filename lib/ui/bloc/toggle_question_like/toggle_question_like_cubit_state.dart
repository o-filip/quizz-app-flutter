import 'package:freezed_annotation/freezed_annotation.dart';

part 'toggle_question_like_cubit_state.freezed.dart';

@freezed
class ToggleQuestionLikeCubitState with _$ToggleQuestionLikeCubitState {
  const factory ToggleQuestionLikeCubitState.initial() = _Initial;
  const factory ToggleQuestionLikeCubitState.toggleInProgress() =
      _ToggleInProgress;
  const factory ToggleQuestionLikeCubitState.done() = _Done;
  const factory ToggleQuestionLikeCubitState.error(
    dynamic error,
  ) = _Error;
}
