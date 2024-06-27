import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/entity/question.dart';

part 'random_question_state.freezed.dart';

sealed class RandomQuestionState {
  const RandomQuestionState();
}

class RandomQuestionStateInitial extends RandomQuestionState {
  const RandomQuestionStateInitial();
}

@freezed
class RandomQuestionStateLoading extends RandomQuestionState
    with _$RandomQuestionStateLoading {
  factory RandomQuestionStateLoading({
    Question? question,
  }) = _RandomQuestionStateLoading;
}

@freezed
class RandomQuestionStateData extends RandomQuestionState
    with _$RandomQuestionStateData {
  factory RandomQuestionStateData({
    required Question question,
  }) = _RandomQuestionStateData;
}

@freezed
class RandomQuestionStateError extends RandomQuestionState
    with _$RandomQuestionStateError {
  factory RandomQuestionStateError({
    required Object error,
  }) = _RandomQuestionStateError;
}
