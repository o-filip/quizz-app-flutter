import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_app/data/converter/question_model_converter.dart';

import '../../fixtures/fixtures.dart';

void main() {
  late QuestionModelConverterImpl questionsConverterImpl;

  setUp(() {
    questionsConverterImpl = QuestionModelConverterImpl();
  });

  group('QuestionsConverterImpl', () {
    test(
        'should convert list of local question local models to list of questions',
        () {
      // Arrange
      final localQuestions = generateQuestionLocalModelFixtures(
        questionCnt: 5,
      );

      final questions = generateQuestionFixtures(
        questionCnt: 5,
      );

      // Act
      final result = questionsConverterImpl.localToEntityList(localQuestions);

      // Assert
      expect(result, questions);
    });

    test('should convert list of question local models to list of questions',
        () {
      // Arrange
      final localQuestions = generateQuestionLocalModelFixtures(
        questionCnt: 5,
      );

      final questions = generateQuestionFixtures(
        questionCnt: 5,
      );

      // Act
      final result = questionsConverterImpl.localToEntityList(localQuestions);

      // Assert
      expect(result, questions);
    });

    test('should convert list of questions to list of question local models',
        () {
      // Arrange
      final question = generateQuestionFixtures(
        questionCnt: 1,
      ).first;

      final localCompanion = generateQuestionLocalModelFixtures(
        questionCnt: 1,
      ).first;

      // Act
      final result = questionsConverterImpl.entityToLocalModel(question);

      // Assert
      // Comparing string representations, because the model contains list
      // and the generated QuestionLocalModel is comparing the list by reference.
      expect(result.toJson(), localCompanion.toJson());
    });
  });
}
