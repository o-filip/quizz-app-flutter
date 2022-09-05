import 'package:async/async.dart';

import '../../core/entity/question.dart';
import '../../core/enum/category.dart';
import '../../core/enum/difficulty.dart';

abstract class QuizRepository {
  Stream<Result<List<Question>>> getQuiz({
    List<Category>? categories,
    Difficulty? difficulty,
    required int minimalNumOfQuestions,
  });

  Stream<Result<List<Question>>> getStoredQuestions({
    bool onlyLiked = false,
  });

  Stream<Result<Question?>> getQuestionById({
    required String id,
  });

  Future<Result<void>> updateQuestion(Question question);
}
