import 'package:freezed_annotation/freezed_annotation.dart';

part 'stored_questions_filter_cubit_state.freezed.dart';

@freezed
class StoredQuestionsFilterCubitState with _$StoredQuestionsFilterCubitState {
  factory StoredQuestionsFilterCubitState({
    @Default(false) bool likedOnly,
  }) = _StoredQuestionsFilterCubitState;
}
