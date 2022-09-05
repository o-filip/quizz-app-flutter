import 'package:mockito/mockito.dart';
import 'package:quiz_app/core/enum/category.dart';
import 'package:quiz_app/core/enum/difficulty.dart';
import 'package:quiz_app/data/local/drift/dao/questions_dao.dart';
import 'package:quiz_app/data/local/drift/database/database.dart';

class MockQuestionsDao extends Mock implements QuestionsDao {
  @override
  Stream<List<QuestionLocalModel>> getQuestions({
    List<Category>? categories,
    Difficulty? difficulty,
    bool likedOnly = false,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #getQuestions,
          [],
          {
            #categories: categories,
            #difficulty: difficulty,
            #likedOnly: likedOnly,
          },
        ),
        returnValue: const Stream<List<QuestionLocalModel>>.empty(),
      ) as Stream<List<QuestionLocalModel>>;

  @override
  Stream<List<QuestionLocalModel>> getQuestionsByIds({
    required Iterable<String>? questionIds,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #getQuestionsByIds,
          [],
          {
            #questionIds: questionIds,
          },
        ),
        returnValue: const Stream<List<QuestionLocalModel>>.empty(),
      ) as Stream<List<QuestionLocalModel>>;

  @override
  Future<void> createOrUpdateQuestions(
    Iterable<QuestionLocalModelsCompanion>? questionsData,
  ) async =>
      super.noSuchMethod(
        Invocation.method(
          #createOrUpdateQuestions,
          [questionsData],
        ),
      );

  @override
  Future<void> createOrUpdateQuestion(
    QuestionLocalModelsCompanion? questionData,
  ) async =>
      super.noSuchMethod(
        Invocation.method(
          #createOrUpdateQuestion,
          [questionData],
        ),
      );
}
