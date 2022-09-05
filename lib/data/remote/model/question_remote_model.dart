import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/enum/category.dart';
import '../../../core/enum/difficulty.dart';

part 'question_remote_model.g.dart';

@JsonSerializable()
class QuestionRemoteModel {
  const QuestionRemoteModel({
    required this.id,
    required this.category,
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswers,
    required this.difficulty,
  });

  factory QuestionRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionRemoteModelFromJson(json);

  final String id;
  final Category category;
  final String question;
  final String correctAnswer;
  final List<String> incorrectAnswers;
  final Difficulty difficulty;
}
