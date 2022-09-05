import '../../../core/entity/answer.dart';
import '../../../core/entity/question.dart';
import '../../../core/enum/category.dart';
import '../../../core/enum/difficulty.dart';

abstract class QuizBlocEvent {}

class GenerateQuizEvent extends QuizBlocEvent {
  GenerateQuizEvent({
    required this.categories,
    required this.difficulty,
    required this.numOfQuestions,
  });

  final List<Category> categories;
  final Difficulty? difficulty;
  final int numOfQuestions;
}

class AnswerQuestionEvent extends QuizBlocEvent {
  AnswerQuestionEvent({
    required this.question,
    required this.answer,
  });

  final Question question;
  final Answer answer;
}
