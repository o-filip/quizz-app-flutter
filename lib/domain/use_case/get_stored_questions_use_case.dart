import 'package:async/async.dart';

import '../../core/entity/question.dart';
import '../../data/repository/quiz_repository.dart';

abstract class GetStoredQuestionsUseCase {
  Stream<Result<List<Question>>> call({
    bool onlyLiked = false,
  });
}

class GetStoredQuestionsUseCaseImpl extends GetStoredQuestionsUseCase {
  GetStoredQuestionsUseCaseImpl({
    required this.quizRepository,
  });

  final QuizRepository quizRepository;

  @override
  Stream<Result<List<Question>>> call({
    bool onlyLiked = false,
  }) =>
      quizRepository.getStoredQuestions(
        onlyLiked: onlyLiked,
      );
}
