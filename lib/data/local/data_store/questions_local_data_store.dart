import '../../../core/enum/category.dart';
import '../../../core/enum/difficulty.dart';
import '../drift/database/database.dart';

abstract class QuestionsLocalDataStore {
  Stream<List<QuestionLocalModel>> getQuestionsByIds({
    required Iterable<String> questionIds,
  });

  Stream<QuestionLocalModel?> getQuestionById({
    required String questionId,
  });

  Stream<List<QuestionLocalModel>> getQuestions({
    List<Category>? categories,
    Difficulty? difficulty,
    bool likedOnly = false,
  });

  Future<void> createOrUpdateQuestions(
    Iterable<QuestionLocalModel> questions,
  );

  Future<void> createOrUpdateQuestion(
    QuestionLocalModel question,
  );
}
