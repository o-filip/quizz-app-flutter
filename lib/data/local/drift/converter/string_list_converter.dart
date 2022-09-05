import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:logging/logging.dart';

class StringListConverter extends TypeConverter<List<String>, String> {
  const StringListConverter();

  static const logTag = 'StringListConverter';

  @override
  List<String> fromSql(String? fromDb) {
    if (fromDb == null) {
      return [];
    }
    try {
      final decodedList = jsonDecode(fromDb) as List<dynamic>;
      return List<String>.from(decodedList);
    } catch (e) {
      Logger(logTag).severe('Failed to decode $fromDb');
      return [];
    }
  }

  @override
  String toSql(List<String> value) => jsonEncode(value);
}
