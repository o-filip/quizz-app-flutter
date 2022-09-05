import '../../../core/enum/category.dart';
import '../../../core/enum/difficulty.dart';
import '../model/question_remote_model.dart';

abstract class QuizRemoteDataStore {
  Future<List<QuestionRemoteModel>> getQuiz({
    List<Category>? categories,
    required int limit,
    String region = 'CZ',
    Difficulty? difficulty,
  });
}
