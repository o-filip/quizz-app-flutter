import 'package:async/async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:quiz_app/core/entity/question.dart';
import 'package:quiz_app/core/error/domain_exception.dart';
import 'package:quiz_app/core/util/answers_permutation_utils.dart';
import 'package:quiz_app/data/repository/quiz_repository.dart';
import 'package:quiz_app/domain/use_case/get_random_question_use_case.dart';

import '../../fixtures/fixtures.dart';
import 'get_random_question_use_case_test.mocks.dart';

@GenerateMocks([
  QuizRepository,
  AnswersPermutationUtils,
])
void main() {
  late GetRandomQuestionUseCaseImpl useCase;
  late MockQuizRepository mockRepository;
  late MockAnswersPermutationUtils mockAnswersPermutationUtils;

  setUp(() {
    mockRepository = MockQuizRepository();
    mockAnswersPermutationUtils = MockAnswersPermutationUtils();
    useCase = GetRandomQuestionUseCaseImpl(
      questionRepository: mockRepository,
      answersPermutationUtils: mockAnswersPermutationUtils,
    );
  });

  group('GetRandomQuestionUseCaseImpl', () {
    test('should emit a random question from the repository', () async {
      // Arrange
      final questions = generateQuestionFixtures(questionCnt: 5);
      final List<int> permutation = [1, 0, 2, 3];
      when(mockRepository.getStoredQuestions())
          .thenAnswer((_) => Stream.value(Result.value(questions)));
      when(mockAnswersPermutationUtils.generateAnswersPermutations(any))
          .thenAnswer((_) => permutation);
      when(mockAnswersPermutationUtils.applyAnswersPermutation(any, any))
          .thenAnswer((i) => i.positionalArguments[0] as Question);

      // Act
      final result = await useCase().first;

      // Assert
      expect(result.isValue, isTrue);
      expect(result.asValue?.value, isIn(questions));
      verify(mockRepository.getStoredQuestions());
      verify(mockAnswersPermutationUtils.generateAnswersPermutations(any));
      verify(mockAnswersPermutationUtils.applyAnswersPermutation(any, any));
      verifyNoMoreInteractions(mockRepository);
      verifyNoMoreInteractions(mockAnswersPermutationUtils);
    });

    test('should emit error if there are no stored questions', () async {
      // Arrange
      when(mockRepository.getStoredQuestions())
          .thenAnswer((_) => Stream.value(Result.value([])));

      // Act
      final result = await useCase().first;

      // Assert
      expect(result.isError, isTrue);
      expect(result.asError?.error, isA<DomainException>());
      verify(mockRepository.getStoredQuestions());
      verifyNoMoreInteractions(mockRepository);
    });

    test('''
        should emit the same question in case questions 
        in stream gets edited''', () async {
      // Arrange
      final questions = generateQuestionFixtures(questionCnt: 5);
      final List<int> permutation = [1, 0, 2, 3];
      const newQuestionText = 'Changed text';
      when(mockRepository.getStoredQuestions()).thenAnswer((_) =>
          Stream.fromIterable([
            questions,
            questions
                .map((question) => question.copyWith(question: newQuestionText))
                .toList(),
          ]).map((event) => Result.value(event)));
      when(mockAnswersPermutationUtils.generateAnswersPermutations(any))
          .thenAnswer((_) => permutation);
      when(mockAnswersPermutationUtils.applyAnswersPermutation(any, any))
          .thenAnswer((i) => i.positionalArguments[0] as Question);

      // Act
      final result = await useCase().toList();

      // Assert
      expect(result.length, greaterThanOrEqualTo(2));
      expect(result.first.isValue, isTrue);
      expect(result[1].isValue, isTrue);
      final val1 = result.first.asValue?.value;
      final val2 = result[1].asValue?.value;
      expect(val1, isNotNull);
      expect(val2, isNotNull);
      expect(val1?.id, equals(val2?.id));
      expect(val2?.question, equals(newQuestionText));
      verify(mockAnswersPermutationUtils.generateAnswersPermutations(any));
      verify(mockAnswersPermutationUtils.applyAnswersPermutation(any, any));
      verify(mockRepository.getStoredQuestions());
      verifyNoMoreInteractions(mockRepository);
      verifyNoMoreInteractions(mockAnswersPermutationUtils);
    });
  });
}
