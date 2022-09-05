import 'package:drift/drift.dart';
import 'package:quiz_app/core/entity/answer.dart';
import 'package:quiz_app/core/entity/question.dart';
import 'package:quiz_app/core/enum/category.dart';
import 'package:quiz_app/core/enum/difficulty.dart';
import 'package:quiz_app/data/local/drift/database/database.dart';
import 'package:quiz_app/data/remote/model/question_remote_model.dart';

List<Question> generateQuestionFixtures({
  required int questionCnt,
}) =>
    List.generate(
      questionCnt,
      (i) => Question(
        id: '$i',
        question: 'Question $i',
        answers: [
          Answer(isCorrect: true, text: 'Answer $i'),
          Answer(isCorrect: false, text: 'Answer ${i + 1}'),
          Answer(isCorrect: false, text: 'Answer ${i + 2}'),
          Answer(isCorrect: false, text: 'Answer ${i + 3}'),
        ],
        category: Category.generalKnowledge,
        difficulty: Difficulty.easy,
        isLiked: false,
      ),
    );

List<QuestionRemoteModel> generateQuestionRemoteModelFixtures({
  required int questionCnt,
}) =>
    List.generate(
      questionCnt,
      (i) => QuestionRemoteModel(
        id: '$i',
        question: 'Question $i',
        correctAnswer: 'Answer $i',
        incorrectAnswers: [
          'Answer ${i + 1}',
          'Answer ${i + 2}',
          'Answer ${i + 3}'
        ],
        category: Category.generalKnowledge,
        difficulty: Difficulty.easy,
      ),
    );

List<QuestionLocalModel> generateQuestionLocalModelFixtures({
  required int questionCnt,
}) =>
    List.generate(
      questionCnt,
      (i) => QuestionLocalModel(
        id: '$i',
        question: 'Question $i',
        correctAnswer: 'Answer $i',
        incorrectAnswers: [
          'Answer ${i + 1}',
          'Answer ${i + 2}',
          'Answer ${i + 3}'
        ],
        category: Category.generalKnowledge,
        difficulty: Difficulty.easy,
        isLiked: false,
      ),
    );

List<QuestionLocalModelsCompanion> generateQuestionLocalModelCompanionFixtures({
  required int questionCnt,
}) =>
    List.generate(
      questionCnt,
      (i) => QuestionLocalModelsCompanion.insert(
        id: '$i',
        question: 'Question $i',
        correctAnswer: 'Answer $i',
        incorrectAnswers: [
          'Answer ${i + 1}',
          'Answer ${i + 2}',
          'Answer ${i + 3}'
        ],
        category: Category.generalKnowledge,
        difficulty: Difficulty.easy,
        isLiked: const Value(false),
      ),
    );
