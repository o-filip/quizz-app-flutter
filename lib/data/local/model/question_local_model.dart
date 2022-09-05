import 'package:drift/drift.dart';

import '../../../core/enum/category.dart';
import '../../../core/enum/difficulty.dart';
import '../drift/converter/string_list_converter.dart';

class QuestionLocalModels extends Table {
  TextColumn get id => text()();
  TextColumn get category => textEnum<Category>()();
  TextColumn get question => text()();
  TextColumn get correctAnswer => text()();
  TextColumn get incorrectAnswers => text().map(const StringListConverter())();
  TextColumn get difficulty => textEnum<Difficulty>()();
  BoolColumn get isLiked => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}
