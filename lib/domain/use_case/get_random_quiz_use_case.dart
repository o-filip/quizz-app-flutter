import 'package:async/async.dart';

import '../../core/entity/question.dart';
import '../../core/enum/category.dart';
import '../../core/enum/difficulty.dart';
import '../../core/error/data_exception.dart';
import '../../core/error/domain_exception.dart';
import '../../core/extension/result_ext.dart';
import '../../core/util/answers_permutation_utils.dart';
import '../../data/repository/quiz_repository.dart';

abstract class GetRandomQuizUseCase {
  Stream<Result<List<Question>>> call({
    List<Category>? categories,
    Difficulty? difficulty,
    required int numOfQuestions,
  });
}

class GetRandomQuizUseCaseImpl extends GetRandomQuizUseCase {
  GetRandomQuizUseCaseImpl({
    required this.quizRepository,
    required this.answersPermutationUtils,
  });

  final QuizRepository quizRepository;
  final AnswersPermutationUtils answersPermutationUtils;

  @override
  Stream<Result<List<Question>>> call({
    List<Category>? categories,
    Difficulty? difficulty,
    required int numOfQuestions,
  }) async* {
    // [selectIds] and [answersPermutation] are used to keep
    // the same order of questions in case of stream emitting new values.
    List<String>? selectedIds;
    List<List<int>>? answersPermutation;

    yield* quizRepository
        .getQuiz(
          categories: categories,
          difficulty: difficulty,
          minimalNumOfQuestions: numOfQuestions,
        )
        .map((questions) => questions.map(
              value: (questions) {
                // Select random subset of questions
                selectedIds ??=
                    generateRandomIdSelection(questions, numOfQuestions);
                final filteredQuestions =
                    filterAndOrderQuestionsByIds(questions, selectedIds!);

                // Generate answers permutations if not exists and apply them
                answersPermutation ??= answersPermutationUtils
                    .generateAnswersPermutationsList(filteredQuestions);

                return answersPermutationUtils.applyAnswersPermutationList(
                  filteredQuestions,
                  answersPermutation!,
                );
              },
              error: (error) {
                if (error is DataException) {
                  return error.maybeMap(
                    notEnoughEntries: (_) =>
                        const DomainException.notEnoughStoredQuestions(),
                    orElse: () => error,
                  );
                } else {
                  return error;
                }
              },
            ));
  }

  /// Selects random subset of [numOfIds] from [questions] and returns their ids.
  List<String> generateRandomIdSelection(
    List<Question> questions,
    int numOfIds,
  ) =>
      (questions.toList()..shuffle()).take(numOfIds).map((e) => e.id).toList();

  /// Filters [questions] by [ids] and orders them in the same order as [ids].
  List<Question> filterAndOrderQuestionsByIds(
    List<Question> questions,
    List<String> ids,
  ) =>
      questions.where((question) => ids.contains(question.id)).toList()
        ..sort((a, b) => ids.indexOf(a.id) - ids.indexOf(b.id));
}
