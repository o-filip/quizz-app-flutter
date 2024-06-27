extension UriExtensions on Uri {
  List<T>? decodeEnumList<T>(String key, List<T> enumValues) {
    return queryParameters[key]
        ?.split(',')
        .map((e) => enumValues[int.parse(e)])
        .toList();
  }
}

extension EnumListExtension on List<Enum> {
  String encodeEnumListToUriQuery() {
    return map((e) => e.index).join(',');
  }
}
