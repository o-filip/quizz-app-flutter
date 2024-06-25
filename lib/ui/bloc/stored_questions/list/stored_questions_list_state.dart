import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/entity/question.dart';

part 'stored_questions_list_state.freezed.dart';

sealed class StoredQuestionsListState {
  const StoredQuestionsListState();
}

class StoredQuestionsListStateInitial extends StoredQuestionsListState {
  const StoredQuestionsListStateInitial();
}

@freezed
class StoredQuestionsListStateLoading extends StoredQuestionsListState
    with _$StoredQuestionsListStateLoading {
  factory StoredQuestionsListStateLoading({
    List<Question>? questions,
  }) = _StoredQuestionsListStateLoading;
}

@freezed
class StoredQuestionsListStateData extends StoredQuestionsListState
    with _$StoredQuestionsListStateData {
  factory StoredQuestionsListStateData({
    required List<Question> questions,
  }) = _StoredQuestionsListStateData;
}

@freezed
class StoredQuestionsListStateError extends StoredQuestionsListState
    with _$StoredQuestionsListStateError {
  factory StoredQuestionsListStateError({
    required Object error,
  }) = _StoredQuestionsListStateError;
}
