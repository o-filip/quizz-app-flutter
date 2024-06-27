import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/entity/answer.dart';
import '../../../core/entity/question.dart';
import '../../../core/enum/category.dart';
import '../../../core/enum/difficulty.dart';
import '../../../core/extension/result_ext.dart';
import '../../../domain/use_case/get_random_quiz_use_case.dart';
import 'quiz_bloc_event.dart';
import 'quiz_state.dart';

class QuizBloc extends Bloc<QuizBlocEvent, QuizState> {
  QuizBloc({
    required this.getRandomQuizUseCase,
  }) : super(const QuizStateInitial()) {
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
    Emitter<QuizState> emit,
  ) async {
    _categories = event.categories;
    _difficulty = event.difficulty;

    emit(const QuizStateLoading());

    final stream = getRandomQuizUseCase(
      categories: event.categories,
      difficulty: event.difficulty,
      numOfQuestions: event.numOfQuestions,
    );

    await emit.onEach(
      stream,
      onData: (quiz) {
        quiz.when(value: 
          (value) => _updateQuizQuestions(value, emit),
          error: (error) => emit(QuizStateError(error: error)),
        );
      },
    );
  }

  void _updateQuizQuestions(
    List<Question> questions,
    Emitter<QuizState> emit,
  ) {
    final state = this.state;

    if (state is QuizStateInitial ||
        state is QuizStateLoading ||
        state is QuizStateError) {
      emit(QuizStateDisplayingQuestion(
        questions: questions,
        currentQuestionIndex: 0,
        selectedAnswers: {},
      ));
    } else if (state is QuizStateDisplayingQuestion) {
      emit(state.copyWith(questions: questions));
    } else if (state is QuizStateFinished) {
      emit(state.copyWith(questions: questions));
    }
  }

  FutureOr<void> _onAnswerQuestionEvent(
    AnswerQuestionEvent event,
    Emitter<QuizState> emit,
  ) {
    final state = this.state;
    if (state is QuizStateDisplayingQuestion) {
      // Update selected answers
      final selectedAnswers = Map<String, Answer>.from(state.selectedAnswers);
      selectedAnswers[event.question.id] = event.answer;

      if (state.currentQuestionIndex == state.questions.length - 1) {
        // It was the last question -> finish quiz
        emit(QuizStateFinished(
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
