import 'package:drift/drift.dart';

import '../../../../core/enum/category.dart';
import '../../../../core/enum/difficulty.dart';
import '../../model/question_local_model.dart';
import '../database/database.dart';
import 'questions_dao.dart';

part 'questions_dao_impl.g.dart';

@DriftAccessor(tables: [QuestionLocalModels])
class QuestionsDaoImpl extends DatabaseAccessor<AppDatabase>
    with _$QuestionsDaoImplMixin
    implements QuestionsDao {
  QuestionsDaoImpl(super.attachedDatabase);

  @override
  Stream<List<QuestionLocalModel>> getQuestionsByIds({
    required Iterable<String> questionIds,
  }) =>
      (select(questionLocalModels)..where((tbl) => tbl.id.isIn(questionIds)))
          .watch();

  @override
  Stream<List<QuestionLocalModel>> getQuestions({
    List<Category>? categories,
    Difficulty? difficulty,
    bool likedOnly = false,
  }) {
    final SimpleSelectStatement<$QuestionLocalModelsTable, QuestionLocalModel>
        query = select(questionLocalModels);

    if (categories?.isNotEmpty ?? false) {
      query.where((tbl) => tbl.category.isIn(categories!.map((e) => e.name)));
    }

    if (difficulty != null) {
      query.where((tbl) => tbl.difficulty.equals(difficulty.name));
    }

    if (likedOnly) {
      query.where((tbl) => tbl.isLiked.equals(true));
    }

    return query.watch();
  }

  @override
  Future<void> createOrUpdateQuestions(
    Iterable<QuestionLocalModelsCompanion> questionsData,
  ) =>
      transaction(() => batch(
            (batch) => batch.insertAllOnConflictUpdate(
              questionLocalModels,
              questionsData,
            ),
          ));

  @override
  Future<void> createOrUpdateQuestion(
    QuestionLocalModelsCompanion questionData,
  ) =>
      into(questionLocalModels).insertOnConflictUpdate(questionData);

  @override
  Stream<QuestionLocalModel?> getQuestionById({
    required String questionId,
  }) =>
      (select(questionLocalModels)..where((tbl) => tbl.id.equals(questionId)))
          .watchSingle();
}
