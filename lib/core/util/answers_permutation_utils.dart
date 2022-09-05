import 'package:collection/collection.dart';

import '../entity/answer.dart';
import '../entity/question.dart';

abstract class AnswersPermutationUtils {
  /// Generates permutation of answers for [question].
  List<int> generateAnswersPermutations(
    Question question,
  );

  /// Generates permutations of answers for each of [questions].
  List<List<int>> generateAnswersPermutationsList(
    List<Question> questions,
  );

  /// Applies [permutation] to [question] and returns new question.
  Question applyAnswersPermutation(
    Question question,
    List<int> permutation,
  );

  /// Applies [permutations] to [questions] and returns new list of questions.
  List<Question> applyAnswersPermutationList(
    List<Question> questions,
    List<List<int>> permutations,
  );
}

class AnswersPermutationUtilsImpl extends AnswersPermutationUtils {
  /// Generates permutation of answers for [question].
  @override
  List<int> generateAnswersPermutations(
    Question question,
  ) =>
      List.generate(question.answers.length, (i) => i)..shuffle();

  /// Generates permutations of answers for each of [questions].
  @override
  List<List<int>> generateAnswersPermutationsList(
    List<Question> questions,
  ) =>
      questions.map((e) => generateAnswersPermutations(e)).toList();

  /// Applies [permutation] to [question] and returns new question.
  @override
  Question applyAnswersPermutation(
    Question question,
    List<int> permutation,
  ) {
    final answers = <Answer>[];
    for (final perm in permutation) {
      answers.add(question.answers[perm]);
    }
    return question.copyWith(answers: answers);
  }

  /// Applies [permutations] to [questions] and returns new list of questions.
  @override
  List<Question> applyAnswersPermutationList(
    List<Question> questions,
    List<List<int>> permutations,
  ) {
    return questions
        .mapIndexed((index, question) =>
            applyAnswersPermutation(question, permutations[index]))
        .toList();
  }
}
