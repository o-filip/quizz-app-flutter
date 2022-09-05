import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/entity/answer.dart';
import '../../../core/entity/question.dart';
import '../../../core/enum/category.dart';
import '../../../core/enum/difficulty.dart';
import '../../../domain/use_case/get_random_quiz_use_case.dart';
import 'quiz_bloc_event.dart';
import 'quiz_bloc_state.dart';

class QuizBloc extends Bloc<QuizBlocEvent, QuizBlocState> {
  QuizBloc({
    required this.getRandomQuizUseCase,
  }) : super(Initial()) {
    on<GenerateQuizEvent>(
      _onGenerateQuizEvent,
      transformer: restartable(),
    );
    on<AnswerQuestionEvent>(_onAnswerQuestionEvent);
  }

  final GetRandomQuizUseCase getRandomQuizUseCase;

  List<Category> _categories = [];
  Difficulty? _difficulty;

  Future<void> _onGenerateQuizEvent(
    GenerateQuizEvent event,
    Emitter<QuizBlocState> emit,
  ) async {
    _categories = event.categories;
    _difficulty = event.difficulty;

    emit(LoadingQuiz());

    final stream = getRandomQuizUseCase(
      categories: event.categories,
      difficulty: event.difficulty,
      numOfQuestions: event.numOfQuestions,
    );

    await emit.onEach(stream, onData: (quiz) {
      if (quiz.isValue) {
        _updateQuizQuestions(quiz.asValue!.value);
      } else {
        emit(QuizError(quiz.asError!.error));
      }
    });
  }

  void _updateQuizQuestions(
    List<Question> questions,
  ) {
    final state = this.state;

    if (state is Initial || state is LoadingQuiz || state is QuizError) {
      emit(DisplayingQuestion(
        questions: questions,
        currentQuestionIndex: 0,
        selectedAnswers: {},
      ));
    } else if (state is DisplayingQuestion) {
      emit(state.copyWith(questions: questions));
    } else if (state is QuizFinished) {
      emit(state.copyWith(questions: questions));
    }
  }

  FutureOr<void> _onAnswerQuestionEvent(
    AnswerQuestionEvent event,
    Emitter<QuizBlocState> emit,
  ) {
    final state = this.state;
    if (state is DisplayingQuestion) {
      // Update selected answers
      final selectedAnswers = Map<String, Answer>.from(state.selectedAnswers);
      selectedAnswers[event.question.id] = event.answer;

      if (state.currentQuestionIndex == state.questions.length - 1) {
        // Quiz finished
        emit(QuizFinished(
          questions: state.questions,
          selectedAnswers: selectedAnswers,
          difficulty: _difficulty,
          categories: _categories,
        ));
      } else {
        emit(state.copyWith(
          currentQuestionIndex: state.currentQuestionIndex + 1,
          selectedAnswers: selectedAnswers,
        ));
      }
    }
  }
}
