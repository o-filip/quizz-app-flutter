import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../../../../core/enum/category.dart';
import '../../../../core/enum/difficulty.dart';
import '../../model/question_local_model.dart';
import '../converter/string_list_converter.dart';

part 'database.g.dart';

@DriftDatabase(tables: [
  QuestionLocalModels,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration =>
      MigrationStrategy(beforeOpen: (detail) async {
        await customStatement('PRAGMA foreign_keys = ON');
      });
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final Directory dbFolder = await getApplicationDocumentsDirectory();
    final File file = File(path.join(dbFolder.path, 'quiz_db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
