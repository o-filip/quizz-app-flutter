import 'package:async/async.dart';

import '../../core/error/domain_exception.dart';
import '../../core/extension/result_ext.dart';
import '../../data/repository/quiz_repository.dart';

abstract class ToggleQuestionLikeUseCase {
  Future<Result<void>> call(String questionId);
}

class ToggleQuestionLikeUseCaseImpl implements ToggleQuestionLikeUseCase {
  ToggleQuestionLikeUseCaseImpl({
    required this.quizRepository,
  });

  final QuizRepository quizRepository;

  @override
  Future<Result<void>> call(String questionId) async {
    final result = await quizRepository.getQuestionById(id: questionId).first;

    return result.mapCatching(
      value: (question) {
        if (question != null) {
          quizRepository.updateQuestion(
            question.copyWith(isLiked: !question.isLiked),
          );
        } else {
          throw const DomainException.questionNotFound();
        }
      },
    );
  }
}
