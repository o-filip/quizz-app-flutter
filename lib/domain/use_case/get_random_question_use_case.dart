import 'dart:math';

import 'package:async/async.dart';

import '../../core/entity/question.dart';
import '../../core/error/exception.dart';
import '../../core/extension/result_ext.dart';
import '../../core/util/answers_permutation_utils.dart';
import '../../data/repository/quiz_repository.dart';

abstract class GetRandomQuestionUseCase {
  Stream<Result<Question?>> call();
}

class GetRandomQuestionUseCaseImpl implements GetRandomQuestionUseCase {
  GetRandomQuestionUseCaseImpl({
    required this.questionRepository,
    required this.answersPermutationUtils,
  });

  final QuizRepository questionRepository;
  final AnswersPermutationUtils answersPermutationUtils;

  @override
  Stream<Result<Question>> call() async* {
    // [questionId] and [answersPermutation] are used to keep
    // the same order of answers in the question
    // in case of stream emitting new values.
    String? questionId;
    List<int>? answersPermutation;

    yield* questionRepository.getStoredQuestions().map((questions) {
      return questions.mapCatching(
        value: (questions) {
          Question result;

          if (questions.isEmpty) {
            // No stored questions
            throw const NoStoredQuestionDomainException();
          } else if (questionId != null) {
            // Stream emitted new values
            result =
                questions.firstWhere((question) => question.id == questionId);
          } else {
            // First time getting random question
            final randomIndex = Random().nextInt(questions.length);
            final resultQuestion = questions[randomIndex];
            questionId = resultQuestion.id;
            result = resultQuestion;
          }
          // Generate answers permutation if not exists and apply it
          answersPermutation ??=
              answersPermutationUtils.generateAnswersPermutations(result);
          return answersPermutationUtils.applyAnswersPermutation(
            result,
            answersPermutation!,
          );
        },
      );
    });
  }
}
