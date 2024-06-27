import 'package:async/async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:quiz_app/core/error/exception.dart';
import 'package:quiz_app/data/repository/quiz_repository.dart';
import 'package:quiz_app/domain/use_case/toggle_question_like_use_case.dart';

import '../../fixtures/fixtures.dart';
import 'get_random_question_use_case_test.mocks.dart';

@GenerateMocks([QuizRepository])
void main() {
  late ToggleQuestionLikeUseCaseImpl useCase;
  late MockQuizRepository mockRepository;

  setUp(() {
    mockRepository = MockQuizRepository();
    useCase = ToggleQuestionLikeUseCaseImpl(
      quizRepository: mockRepository,
    );
  });

  group('ToggleQuestionLikeUseCaseImpl', () {
    test('should toggle the question like status', () async {
      // Arrange
      final mockQuestion = generateQuestionFixtures(questionCnt: 1)
          .first
          .copyWith(isLiked: true);
      when(mockRepository.getQuestionById(id: anyNamed('id'))).thenAnswer(
        (_) => Stream.value(Result.value(mockQuestion)),
      );
      when(mockRepository.updateQuestion(any))
          .thenAnswer((_) async => Result.value(null));

      // Act
      await useCase(mockQuestion.id);

      // Assert
      verify(mockRepository.getQuestionById(id: mockQuestion.id));
      verify(
        mockRepository.updateQuestion(mockQuestion.copyWith(isLiked: false)),
      );
      verifyNoMoreInteractions(mockRepository);
    });

    test('returns error if id of not existing question is provided', () async {
      // Arrange
      when(mockRepository.getQuestionById(id: anyNamed('id'))).thenAnswer(
        (_) => Stream.value(Result.value(null)),
      );

      // Act
      final result = await useCase('0');

      // Assert
      expect(result.isError, isTrue);
      expect(result.asError?.error, isA<DomainException>());
      verify(mockRepository.getQuestionById(id: '0'));

      verifyNoMoreInteractions(mockRepository);
    });
  });
}
