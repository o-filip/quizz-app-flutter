import 'package:freezed_annotation/freezed_annotation.dart';

import '../enum/category.dart';
import '../enum/difficulty.dart';
import 'answer.dart';

part 'question.freezed.dart';

@freezed
class Question with _$Question {
  const factory Question({
    required String id,
    required Category category,
    required String question,
    required List<Answer> answers,
    required Difficulty difficulty,
    required bool isLiked,
  }) = _Question;
}
