import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_exception.freezed.dart';

@freezed
class BaseException with _$BaseException implements Exception {
  const factory BaseException() = _BaseException;
}
