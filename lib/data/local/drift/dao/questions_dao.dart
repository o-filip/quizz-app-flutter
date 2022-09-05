import '../../../../core/enum/category.dart';
import '../../../../core/enum/difficulty.dart';
import '../database/database.dart';

abstract class QuestionsDao {
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
    Iterable<QuestionLocalModelsCompanion> questionsData,
  );

  Future<void> createOrUpdateQuestion(
    QuestionLocalModelsCompanion questionData,
  );
}
