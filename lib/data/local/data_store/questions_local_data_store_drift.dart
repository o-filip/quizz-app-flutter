import '../../../core/enum/category.dart';
import '../../../core/enum/difficulty.dart';
import '../../converter/question_model_converter.dart';
import '../drift/dao/questions_dao.dart';
import '../drift/data_store/base_drift_local_data_store.dart';
import '../drift/database/database.dart';
import 'questions_local_data_store.dart';

class QuestionsLocalDataStoreDrift extends QuestionsLocalDataStore
    with BaseDriftLocalDataStore {
  QuestionsLocalDataStoreDrift({
    required this.questionsDao,
    required this.questionsConverter,
  });

  final QuestionsDao questionsDao;
  final QuestionModelConverter questionsConverter;

  @override
  Future<void> createOrUpdateQuestion(QuestionLocalModel question) =>
      driftDo(() => questionsDao.createOrUpdateQuestion(
            question.toCompanion(true),
          ));

  @override
  Future<void> createOrUpdateQuestions(
    Iterable<QuestionLocalModel> questions,
  ) =>
      driftDo(() => questionsDao.createOrUpdateQuestions(
            questions.map((e) => e.toCompanion(true)),
          ));

  @override
  Stream<List<QuestionLocalModel>> getQuestions({
    List<Category>? categories,
    Difficulty? difficulty,
    bool likedOnly = false,
  }) =>
      driftFetch(() => questionsDao.getQuestions(
            categories: categories,
            difficulty: difficulty,
            likedOnly: likedOnly,
          ));

  @override
  Stream<List<QuestionLocalModel>> getQuestionsByIds({
    required Iterable<String> questionIds,
  }) =>
      driftFetch(
        () => questionsDao.getQuestionsByIds(questionIds: questionIds),
      );

  @override
  Stream<QuestionLocalModel?> getQuestionById({required String questionId}) =>
      driftFetch(() => questionsDao.getQuestionById(questionId: questionId));
}
