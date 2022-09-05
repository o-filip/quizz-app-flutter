import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/entity/answer.dart';
import '../../../core/entity/question.dart';
import '../../../core/enum/category.dart';
import '../../../core/enum/difficulty.dart';

part 'quiz_bloc_state.freezed.dart';

abstract class QuizBlocState {}

@freezed
class Initial extends QuizBlocState with _$Initial {
  factory Initial() = _Initial;
}

@freezed
class LoadingQuiz extends QuizBlocState with _$LoadingQuiz {
  factory LoadingQuiz() = _LoadingQuiz;
}

@freezed
class QuizError extends QuizBlocState with _$QuizError {
  factory QuizError(Object error) = _QuizError;
}

@freezed
class DisplayingQuestion extends QuizBlocState with _$DisplayingQuestion {
  factory DisplayingQuestion({
    required List<Question> questions,
    required int currentQuestionIndex,
    required Map<String, Answer> selectedAnswers,
  }) = _DisplayingQuestion;

  DisplayingQuestion._();

  Question get currentQuestion => questions[currentQuestionIndex];
}

@freezed
class QuizFinished extends QuizBlocState with _$QuizFinished {
  factory QuizFinished({
    required List<Question> questions,
    required Map<String, Answer> selectedAnswers,
    required Difficulty? difficulty,
    required List<Category> categories,
  }) = _QuizFinished;

  QuizFinished._();

  int get correctAnswersCount =>
      selectedAnswers.values.where((e) => e.isCorrect).length;
}
