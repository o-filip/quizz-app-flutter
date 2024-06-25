import 'dart:async';

import 'package:async/async.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:quiz_app/core/entity/answer.dart';
import 'package:quiz_app/core/enum/category.dart';
import 'package:quiz_app/core/enum/difficulty.dart';
import 'package:quiz_app/domain/use_case/get_random_quiz_use_case.dart';
import 'package:quiz_app/ui/bloc/quiz/quiz_bloc.dart';
import 'package:quiz_app/ui/bloc/quiz/quiz_bloc_event.dart';
import 'package:quiz_app/ui/bloc/quiz/quiz_state.dart';

import '../../fixtures/fixtures.dart';
import 'quiz_bloc_test.mocks.dart';

@GenerateMocks([GetRandomQuizUseCase])
void main() {
  late QuizBloc quizBloc;
  late MockGetRandomQuizUseCase mockGetRandomQuizUseCase;

  final questions = generateQuestionFixtures(questionCnt: 2);
  const answer = Answer(
    text: 'Text',
    isCorrect: true,
  );
  final categories = [Category.artsAndLiterature];
  const difficulty = Difficulty.easy;
  const numOfQuestions = 2;

  setUp(() {
    mockGetRandomQuizUseCase = MockGetRandomQuizUseCase();
    quizBloc = QuizBloc(getRandomQuizUseCase: mockGetRandomQuizUseCase);
  });

  tearDown(() {
    quizBloc.close();
  });

  group('QuizBloc', () {
    test('emits DisplayingQuestion state when GenerateQuizEvent is triggered',
        () async {
      when(mockGetRandomQuizUseCase(
        categories: anyNamed('categories'),
        difficulty: anyNamed('difficulty'),
        numOfQuestions: anyNamed('numOfQuestions'),
      )).thenAnswer(
        (_) => Stream.value(Result.value(questions)),
      );

      final event = GenerateQuizEvent(
        categories: categories,
        difficulty: difficulty,
        numOfQuestions: numOfQuestions,
      );

      final expectedStates = [
        const QuizStateLoading(),
        QuizStateDisplayingQuestion(
          questions: questions,
          currentQuestionIndex: 0,
          selectedAnswers: {},
        ),
      ];

      await testBloc(
        build: () => quizBloc,
        act: (bloc) => bloc.add(event),
        expect: () => expectedStates,
        verify: (_) {
          verify(mockGetRandomQuizUseCase(
            categories: categories,
            difficulty: difficulty,
            numOfQuestions: numOfQuestions,
          ));
          verifyNoMoreInteractions(mockGetRandomQuizUseCase);
        },
      );
    });

    test(
        'updates quiz questions when like flag of one of the questions changes',
        () async {
      final updatedQuestions = questions
          .mapIndexed((index, e) => index == 0 ? e.copyWith(isLiked: true) : e)
          .toList();

      when(mockGetRandomQuizUseCase(
        categories: categories,
        difficulty: difficulty,
        numOfQuestions: numOfQuestions,
      )).thenAnswer((_) => Stream.fromIterable([
            Result.value(questions),
            Result.value(updatedQuestions),
          ]));

      final event = GenerateQuizEvent(
        categories: categories,
        difficulty: difficulty,
        numOfQuestions: numOfQuestions,
      );

      final expectedStates = [
        const QuizStateLoading(),
        QuizStateDisplayingQuestion(
          questions: questions,
          currentQuestionIndex: 0,
          selectedAnswers: {},
        ),
        QuizStateDisplayingQuestion(
          questions: updatedQuestions,
          currentQuestionIndex: 0,
          selectedAnswers: {},
        ),
      ];

      await testBloc(
        build: () => quizBloc,
        act: (bloc) => bloc.add(event),
        expect: () => expectedStates,
        verify: (_) {
          verify(mockGetRandomQuizUseCase(
            categories: categories,
            difficulty: difficulty,
            numOfQuestions: numOfQuestions,
          ));
          verifyNoMoreInteractions(mockGetRandomQuizUseCase);
        },
      );
    });

    test(
        'emits QuizFinished state when AnswerQuestionEvent is triggered for the last question',
        () async {
      final currentState = QuizStateDisplayingQuestion(
        questions: questions,
        currentQuestionIndex: questions.length - 1,
        selectedAnswers: {},
      );
      final expectedState = QuizStateFinished(
        questions: questions,
        selectedAnswers: {
          questions.last.id: answer,
        },
        difficulty: null,
        categories: [],
      );
      final event = AnswerQuestionEvent(
        question: questions.last,
        answer: answer,
      );

      await testBloc<QuizBloc, QuizState>(
        build: () => quizBloc,
        seed: () => currentState,
        act: (bloc) => bloc.add(event),
        expect: () => [expectedState],
      );
    });

    test(
        'does not emit QuizFinished state when AnswerQuestionEvent is triggered for a non-last question',
        () async {
      final currentState = QuizStateDisplayingQuestion(
        questions: questions,
        currentQuestionIndex: 0,
        selectedAnswers: {},
      );
      final expectedState = currentState.copyWith(
        currentQuestionIndex: 1,
        selectedAnswers: {
          questions.first.id: answer,
        },
      );
      final event = AnswerQuestionEvent(
        question: questions.first,
        answer: answer,
      );

      await testBloc<QuizBloc, QuizState>(
        build: () => quizBloc,
        seed: () => currentState,
        act: (bloc) => bloc.add(event),
        expect: () => [expectedState],
      );
    });

    test('emits QuizError state when GenerateQuizEvent ends with error',
        () async {
      final error = Exception('Error');

      when(mockGetRandomQuizUseCase(
        categories: anyNamed('categories'),
        difficulty: anyNamed('difficulty'),
        numOfQuestions: anyNamed('numOfQuestions'),
      )).thenAnswer(
        (_) => Stream.value(Result.error(error)),
      );

      final event = GenerateQuizEvent(
        categories: categories,
        difficulty: difficulty,
        numOfQuestions: numOfQuestions,
      );

      final expectedStates = [
        const QuizStateLoading(),
        QuizStateError(error: error),
      ];

      await testBloc(
        build: () => quizBloc,
        act: (bloc) => bloc.add(event),
        expect: () => expectedStates,
        verify: (_) {
          verify(mockGetRandomQuizUseCase(
            categories: categories,
            difficulty: difficulty,
            numOfQuestions: numOfQuestions,
          ));
          verifyNoMoreInteractions(mockGetRandomQuizUseCase);
        },
      );
    });
  });
}
