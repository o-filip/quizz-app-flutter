import 'package:mockito/mockito.dart';
import 'package:quiz_app/core/entity/question.dart';
import 'package:quiz_app/data/converter/question_model_converter.dart';
import 'package:quiz_app/data/local/drift/database/database.dart';
import 'package:quiz_app/data/remote/model/question_remote_model.dart';

import '../fixtures/fixtures.dart';

class MockQuestionsConverter extends Mock implements QuestionModelConverter {
  @override
  QuestionLocalModel remoteToLocalModel(QuestionRemoteModel? remote) =>
      super.noSuchMethod(Invocation.method(
        #remoteToLocalModel,
        [remote],
      )) as QuestionLocalModel;
  @override
  List<QuestionLocalModel> remoteToLocalModelList(
          Iterable<QuestionRemoteModel>? remote) =>
      super.noSuchMethod(
        Invocation.method(
          #remoteToLocalModelList,
          [remote],
        ),
        returnValue: <QuestionLocalModel>[],
      ) as List<QuestionLocalModel>;
  @override
  QuestionLocalModel entityToLocalModel(Question? question) =>
      super.noSuchMethod(
          Invocation.method(
            #entityToLocalModel,
            [question],
          ),
          returnValue: generateQuestionLocalModelFixtures(questionCnt: 1)
              .first) as QuestionLocalModel;
  @override
  List<QuestionLocalModel> entityToLocalModelList(
          Iterable<Question>? question) =>
      super.noSuchMethod(
        Invocation.method(
          #entityToLocalModelList,
          [question],
        ),
        returnValue: <QuestionLocalModel>[],
      ) as List<QuestionLocalModel>;
  @override
  Question localToEntity(dynamic local) => super.noSuchMethod(Invocation.method(
        #localToEntity,
        [local],
      )) as Question;
  @override
  List<Question> localToEntityList(Iterable<dynamic>? local) =>
      super.noSuchMethod(
        Invocation.method(
          #localToEntityList,
          [local],
        ),
        returnValue: <Question>[],
      ) as List<Question>;
}
