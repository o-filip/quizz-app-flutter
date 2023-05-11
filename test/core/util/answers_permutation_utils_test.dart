import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_app/core/util/answers_permutation_utils.dart';

import '../../fixtures/fixtures.dart';

void main() {
  group('AnswersPermutationUtils', () {
    late AnswersPermutationUtils utils;

    setUp(() {
      utils = AnswersPermutationUtilsImpl();
    });

    const questionsCount = 2;
    const answersCount = 4;
    final questions = generateQuestionFixtures(questionCnt: questionsCount);

    test('generateAnswersPermutations returns correct permutation', () {
      // Arrange
      final question = questions.first;

      // Act
      final result = utils.generateAnswersPermutations(question);

      // Assert
      expect(result, hasLength(question.answers.length));
      expect(result.toSet(), {0, 1, 2, 3});
    });

    test('generateAnswersPermutationsList returns correct permutations list',
        () {
      // Act
      final result = utils.generateAnswersPermutationsList(questions);

      // Assert
      expect(result, hasLength(questionsCount));
      for (final perm in result) {
        expect(perm, hasLength(answersCount));
        expect(perm.toSet(), {0, 1, 2, 3});
      }
    });

    test('applyAnswersPermutation applies permutation correctly', () {
      // Arrange
      final question = questions.first;
      final permutation = [2, 0, 1, 3];

      // Act
      final result = utils.applyAnswersPermutation(question, permutation);

      // Assert
      expect(result.answers, [
        question.answers[2],
        question.answers[0],
        question.answers[1],
        question.answers[3],
      ]);
    });

    test(
        'applyAnswersPermutationList applies permutations to questions correctly',
        () {
      // Arrange
      final permutations = [
        [1, 0, 2, 3],
        [2, 0, 1, 3],
      ];

      // Act
      final result = utils.applyAnswersPermutationList(questions, permutations);

      // Assert
      expect(result, hasLength(questionsCount));
      expect(result[0].answers, [
        questions[0].answers[1],
        questions[0].answers[0],
        questions[0].answers[2],
        questions[0].answers[3],
      ]);
      expect(result[1].answers, [
        questions[1].answers[2],
        questions[1].answers[0],
        questions[1].answers[1],
        questions[1].answers[3],
      ]);
    });
  });
}
