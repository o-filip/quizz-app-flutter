import 'package:freezed_annotation/freezed_annotation.dart';

import 'base_exception.dart';

part 'data_exception.freezed.dart';

@freezed
class DataException with _$DataException implements BaseException {
  const factory DataException.timeout({
    dynamic cause,
  }) = _Timeout;

  const factory DataException.unauthorized({
    dynamic cause,
  }) = _Unauthorized;

  const factory DataException.canceled({
    dynamic cause,
  }) = _Canceled;

  const factory DataException.notFound({
    dynamic cause,
  }) = _NotFound;

  const factory DataException.unknown({
    dynamic cause,
  }) = _Unknown;

  const factory DataException.connectionError({
    dynamic cause,
  }) = _ConnectionError;

  const factory DataException.invalidOutputFormat({
    dynamic cause,
  }) = _InvalidOutputFormat;

  const factory DataException.notEnoughEntries({
    dynamic cause,
  }) = _NotEnoughEntries;
}
