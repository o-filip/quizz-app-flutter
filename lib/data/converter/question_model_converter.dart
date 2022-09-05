import '../../core/entity/answer.dart';
import '../../core/entity/question.dart';
import '../local/drift/database/database.dart';
import '../remote/model/question_remote_model.dart';

abstract class QuestionModelConverter {
  QuestionLocalModel remoteToLocalModel(QuestionRemoteModel remote);

  List<QuestionLocalModel> remoteToLocalModelList(
    Iterable<QuestionRemoteModel> remote,
  );

  QuestionLocalModel entityToLocalModel(Question question);

  List<QuestionLocalModel> entityToLocalModelList(Iterable<Question> question);

  Question localToEntity(QuestionLocalModel local);

  List<Question> localToEntityList(Iterable<QuestionLocalModel> local);
}

class QuestionModelConverterImpl extends QuestionModelConverter {
  @override
  QuestionLocalModel entityToLocalModel(Question question) =>
      QuestionLocalModel(
        id: question.id,
        category: question.category,
        question: question.question,
        correctAnswer: question.answers.firstWhere((e) => e.isCorrect).text,
        incorrectAnswers: question.answers
            .where((e) => !e.isCorrect)
            .map((e) => e.text)
            .toList(),
        difficulty: question.difficulty,
        isLiked: question.isLiked,
      );

  @override
  List<QuestionLocalModel> entityToLocalModelList(
    Iterable<Question> question,
  ) =>
      question.map((e) => entityToLocalModel(e)).toList();

  @override
  Question localToEntity(QuestionLocalModel local) => Question(
        id: local.id,
        category: local.category,
        question: local.question,
        answers: [
          Answer(
            text: local.correctAnswer,
            isCorrect: true,
          ),
          ...local.incorrectAnswers.map((e) => Answer(
                text: e,
                isCorrect: false,
              )),
        ],
        difficulty: local.difficulty,
        isLiked: local.isLiked,
      );

  @override
  List<Question> localToEntityList(Iterable<QuestionLocalModel> local) =>
      local.map((e) => localToEntity(e)).toList();

  @override
  QuestionLocalModel remoteToLocalModel(QuestionRemoteModel remote) =>
      QuestionLocalModel(
        id: remote.id,
        category: remote.category,
        question: remote.question,
        correctAnswer: remote.correctAnswer,
        incorrectAnswers: remote.incorrectAnswers,
        difficulty: remote.difficulty,
        isLiked: false,
      );

  @override
  List<QuestionLocalModel> remoteToLocalModelList(
    Iterable<QuestionRemoteModel> remote,
  ) =>
      remote.map((e) => remoteToLocalModel(e)).toList();
}
