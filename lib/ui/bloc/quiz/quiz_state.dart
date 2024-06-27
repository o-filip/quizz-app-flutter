import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/entity/answer.dart';
import '../../../core/entity/question.dart';
import '../../../core/enum/category.dart';
import '../../../core/enum/difficulty.dart';

part 'quiz_state.freezed.dart';

sealed class QuizState {
  const QuizState();
}

class QuizStateInitial extends QuizState {
  const QuizStateInitial();
}

class QuizStateLoading extends QuizState {
  const QuizStateLoading();
}

@freezed
class QuizStateError extends QuizState with _$QuizStateError {
  factory QuizStateError({
    required dynamic error,
  }) = _QuizStateError;
}

@freezed
class QuizStateDisplayingQuestion extends QuizState
    with _$QuizStateDisplayingQuestion {
  factory QuizStateDisplayingQuestion({
    required List<Question> questions,
    required int currentQuestionIndex,
    required Map<String, Answer> selectedAnswers,
  }) = _QuizStateDisplayingQuestion;

  QuizStateDisplayingQuestion._();

  Question get currentQuestion => questions[currentQuestionIndex];
}

@freezed
class QuizStateFinished extends QuizState with _$QuizStateFinished {
  factory QuizStateFinished({
    required List<Question> questions,
    required Map<String, Answer> selectedAnswers,
    required Difficulty? difficulty,
    required List<Category> categories,
  }) = _QuizStateFinished;

  QuizStateFinished._();

  int get correctAnswersCount =>
      selectedAnswers.values.where((e) => e.isCorrect).length;
}
