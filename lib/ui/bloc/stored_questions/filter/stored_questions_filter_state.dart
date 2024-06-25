import 'package:freezed_annotation/freezed_annotation.dart';

part 'stored_questions_filter_state.freezed.dart';

@freezed
class StoredQuestionsFilterState with _$StoredQuestionsFilterState {
  factory StoredQuestionsFilterState({
    @Default(false) bool likedOnly,
  }) = _StoredQuestionsFilterState;
}
