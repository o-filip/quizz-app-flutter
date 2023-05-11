import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_app/data/local/drift/converter/string_list_converter.dart';

void main() {
  group('StringListConverter', () {
    const converter = StringListConverter();

    test('fromSql should convert JSON string to List<String>', () {
      const jsonString = '["Apple", "Banana", "Orange"]';
      final result = converter.fromSql(jsonString);

      expect(result, isA<List<String>>());
      expect(result.length, 3);
      expect(result[0], 'Apple');
      expect(result[1], 'Banana');
      expect(result[2], 'Orange');
    });

    test('fromSql should return an empty list when input is null', () {
      final result = converter.fromSql(null);

      expect(result, isA<List<String>>());
      expect(result.length, 0);
    });

    test('toSql should convert List<String> to JSON string', () {
      final input = ['Apple', 'Banana', 'Orange'];
      final result = converter.toSql(input);

      expect(result, isA<String>());
      expect(result, '["Apple","Banana","Orange"]');
    });

    test('toSql should handle special characters in strings', () {
      final input = ['Apple[0]', 'Ba"nana"', "O'Reilly"];
      final result = converter.toSql(input);

      expect(result, isA<String>());
      expect(result, '["Apple[0]","Ba\\"nana\\"","O\'Reilly"]');
    });

    test('fromSql should handle special characters in strings', () {
      const input = '["Apple[0]","Ba\\"nana\\"","O\'Reilly"]';
      final result = converter.fromSql(input);

      expect(result, isA<List<String>>());
      expect(result, ['Apple[0]', 'Ba"nana"', "O'Reilly"]);
    });
  });
}
