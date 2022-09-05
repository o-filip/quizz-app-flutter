import 'package:async/async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:quiz_app/data/repository/quiz_repository.dart';
import 'package:quiz_app/domain/use_case/get_stored_questions_use_case.dart';

import '../../fixtures/fixtures.dart';
import 'get_random_question_use_case_test.mocks.dart';

@GenerateMocks([QuizRepository])
void main() {
  late GetStoredQuestionsUseCaseImpl useCase;
  late QuizRepository mockRepository;

  setUp(() {
    mockRepository = MockQuizRepository();
    useCase = GetStoredQuestionsUseCaseImpl(
      quizRepository: mockRepository,
    );
  });

  group('GetQuestionsUseCaseImpl', () {
    test('should return a stream of questions', () async {
      // Arrange
      final mockQuestions = generateQuestionFixtures(questionCnt: 5);
      when(mockRepository.getStoredQuestions())
          .thenAnswer((_) => Stream.value(Result.value(mockQuestions)));

      // Act
      final result = await useCase().first;

      // Assert
      expect(result.isValue, isTrue);
      expect(result.asValue?.value, mockQuestions);
      verify(mockRepository.getStoredQuestions());
    });
  });
}
