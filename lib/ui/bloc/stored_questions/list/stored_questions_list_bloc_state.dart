import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/entity/question.dart';

part 'stored_questions_list_bloc_state.freezed.dart';

@freezed
class StoredQuestionsListBlocState with _$StoredQuestionsListBlocState {
  factory StoredQuestionsListBlocState.initial() = _Initial;

  factory StoredQuestionsListBlocState.loading({
    List<Question>? questions,
  }) = _Loading;

  factory StoredQuestionsListBlocState.loaded({
    required List<Question> questions,
  }) = _Loaded;

  factory StoredQuestionsListBlocState.error({
    required Object error,
  }) = _Error;
}
