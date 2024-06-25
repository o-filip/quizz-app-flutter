import 'dart:async';

import 'package:async/async.dart';
import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:quiz_app/core/entity/question.dart';
import 'package:quiz_app/core/enum/category.dart';
import 'package:quiz_app/core/enum/difficulty.dart';
import 'package:quiz_app/core/error/exception.dart';
import 'package:quiz_app/core/util/answers_permutation_utils.dart';
import 'package:quiz_app/data/repository/quiz_repository.dart';
import 'package:quiz_app/domain/use_case/get_random_quiz_use_case.dart';

import '../../fixtures/fixtures.dart';
import 'get_random_quiz_use_case_test.mocks.dart';

@GenerateMocks([
  QuizRepository,
  AnswersPermutationUtils,
])
void main() {
  late GetRandomQuizUseCase useCase;
  late MockQuizRepository mockQuizRepository;
  late MockAnswersPermutationUtils mockAnswersPermutationUtils;

  setUp(() {
    mockQuizRepository = MockQuizRepository();
    mockAnswersPermutationUtils = MockAnswersPermutationUtils();
    useCase = GetRandomQuizUseCaseImpl(
      quizRepository: mockQuizRepository,
      answersPermutationUtils: mockAnswersPermutationUtils,
    );
  });

  group('GetRandomQuizUseCaseImpl', () {
    final categories = [Category.generalKnowledge];
    const difficulty = Difficulty.easy;
    const numOfQuestions = 3;
    final permutations =
        List.generate(numOfQuestions, (_) => List.generate(4, (i) => i));

    void setupMocks(List<Question> questions) {
      when(mockQuizRepository.getQuiz(
        categories: anyNamed('categories'),
        difficulty: anyNamed('difficulty'),
        minimalNumOfQuestions: numOfQuestions,
      )).thenAnswer((_) => Stream.value(Result.value(questions)));
      when(mockAnswersPermutationUtils.generateAnswersPermutationsList(any))
          .thenReturn(permutations);
      when(mockAnswersPermutationUtils.applyAnswersPermutationList(any, any))
          .thenAnswer(
              (i) => (i.positionalArguments[0] as List<dynamic>).cast());
    }

    test('should successfully emit list of questions with correct length',
        () async {
      // arrange
      final questions = generateQuestionFixtures(questionCnt: 5);
      setupMocks(questions);

      // act
      final result = await useCase(
        categories: categories,
        difficulty: difficulty,
        numOfQuestions: numOfQuestions,
      ).toList();

      // assert
      expect(result.length, equals(1));
      expect(result.first.isValue, isTrue);
      expect(result.first.asValue?.value.length, equals(numOfQuestions));
      verify(mockQuizRepository.getQuiz(
        categories: categories,
        difficulty: difficulty,
        minimalNumOfQuestions: numOfQuestions,
      ));
      verify(mockAnswersPermutationUtils.generateAnswersPermutationsList(any));
      verify(mockAnswersPermutationUtils.applyAnswersPermutationList(any, any));
      verifyNoMoreInteractions(mockQuizRepository);
      verifyNoMoreInteractions(mockAnswersPermutationUtils);
    });

    test('should successfully emit list of shuffled questions', () async {
      // arrange
      final questions = generateQuestionFixtures(questionCnt: 5);
      setupMocks(questions);

      // act
      final result = await useCase(
        categories: categories,
        difficulty: difficulty,
        numOfQuestions: numOfQuestions,
      ).toList();

      // assert
      expect(
        result.first.asValue?.value,
        isNot(orderedEquals(questions.take(numOfQuestions))),
      );
      verify(mockQuizRepository.getQuiz(
        categories: categories,
        difficulty: difficulty,
        minimalNumOfQuestions: numOfQuestions,
      ));
      verifyNoMoreInteractions(mockQuizRepository);
    });

    test('emits error on failure', () async {
      // arrange
      when(mockQuizRepository.getQuiz(
        categories: anyNamed('categories'),
        difficulty: anyNamed('difficulty'),
        minimalNumOfQuestions: numOfQuestions,
      )).thenThrow(const UnknownDataException());

      // act
      final stream = useCase(
        categories: categories,
        difficulty: difficulty,
        numOfQuestions: numOfQuestions,
      );

      // assert
      expectLater(
        stream,
        emitsError(isA<DataException>()),
      );
      await Future.delayed(Duration.zero);
      verify(mockQuizRepository.getQuiz(
        categories: categories,
        difficulty: difficulty,
        minimalNumOfQuestions: numOfQuestions,
      ));
      verifyNoMoreInteractions(mockQuizRepository);
    });

    test(
        'emits questions in the same order in case the list of questions in stream gets edited',
        () async {
      // Arrange
      final questions = generateQuestionFixtures(questionCnt: 3);
      when(mockQuizRepository.getQuiz(
        categories: anyNamed('categories'),
        difficulty: anyNamed('difficulty'),
        minimalNumOfQuestions: anyNamed('minimalNumOfQuestions'),
      )).thenAnswer((_) => Stream.fromIterable([
            questions,
            questions
                .mapIndexed((index, q) =>
                    index == 2 ? q.copyWith(question: 'Changed text') : q)
                .toList(),
          ]).map((event) => Result.value(event)));
      when(mockAnswersPermutationUtils.generateAnswersPermutationsList(any))
          .thenReturn(permutations);
      when(mockAnswersPermutationUtils.applyAnswersPermutationList(any, any))
          .thenAnswer(
              (i) => (i.positionalArguments[0] as List<dynamic>).cast());

      // Act
      final result = await useCase(
        categories: categories,
        difficulty: difficulty,
        numOfQuestions: numOfQuestions,
      ).toList();

      // Assert
      expect(result.length, greaterThanOrEqualTo(2));
      expect(result.first.isValue, isTrue);
      expect(result[1].isValue, isTrue);
      final val1 = result.first.asValue!.value;
      final val2 = result[1].asValue!.value;
      expect(val1.length, equals(numOfQuestions));
      expect(val2.length, equals(numOfQuestions));
      final idsFirst = val1.map((e) => e.id).toList();
      final idsSecond = val2.map((e) => e.id).toList();
      expect(idsFirst, orderedEquals(idsSecond));
      verify(mockQuizRepository.getQuiz(
        categories: categories,
        difficulty: difficulty,
        minimalNumOfQuestions: numOfQuestions,
      ));
      verify(mockAnswersPermutationUtils.generateAnswersPermutationsList(any));
      verify(mockAnswersPermutationUtils.applyAnswersPermutationList(any, any));
      verifyNoMoreInteractions(mockQuizRepository);
      verifyNoMoreInteractions(mockAnswersPermutationUtils);
    });
  });
}
