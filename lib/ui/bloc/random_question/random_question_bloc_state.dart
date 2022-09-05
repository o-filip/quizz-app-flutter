import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/entity/question.dart';

part 'random_question_bloc_state.freezed.dart';

@freezed
class RandomQuestionBlocState with _$RandomQuestionBlocState {
  const factory RandomQuestionBlocState.initial() = _Initial;

  const factory RandomQuestionBlocState.loading({
    Question? question,
  }) = _Loading;

  const factory RandomQuestionBlocState.loaded(
    Question question,
  ) = _Loaded;

  const factory RandomQuestionBlocState.error(
    dynamic error,
  ) = _Error;
}
