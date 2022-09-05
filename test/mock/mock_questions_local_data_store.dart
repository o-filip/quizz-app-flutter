import 'package:mockito/mockito.dart';
import 'package:quiz_app/core/enum/category.dart';
import 'package:quiz_app/core/enum/difficulty.dart';
import 'package:quiz_app/data/local/data_store/questions_local_data_store.dart';
import 'package:quiz_app/data/local/drift/database/database.dart';

class MockQuestionsLocalDataStore extends Mock
    implements QuestionsLocalDataStore {
  @override
  Stream<List<QuestionLocalModel>> getQuestionsByIds(
          {required Iterable<String>? questionIds}) =>
      super.noSuchMethod(
        Invocation.method(
          #getQuestionsByIds,
          [],
          {#questionIds: questionIds},
        ),
        returnValue: const Stream<List<QuestionLocalModel>>.empty(),
      ) as Stream<List<QuestionLocalModel>>;
  @override
  Stream<List<QuestionLocalModel>> getQuestions({
    List<Category>? categories,
    Difficulty? difficulty,
    bool? likedOnly = false,
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
  Future<void> createOrUpdateQuestions(
          Iterable<QuestionLocalModel>? questions) =>
      super.noSuchMethod(
        Invocation.method(
          #createOrUpdateQuestions,
          [questions],
        ),
        returnValue: Future<void>.value(),
        returnValueForMissingStub: Future<void>.value(),
      ) as Future<void>;
  @override
  Future<void> createOrUpdateQuestion(QuestionLocalModel? question) =>
      super.noSuchMethod(
        Invocation.method(
          #createOrUpdateQuestion,
          [question],
        ),
        returnValue: Future<void>.value(),
        returnValueForMissingStub: Future<void>.value(),
      ) as Future<void>;
}
