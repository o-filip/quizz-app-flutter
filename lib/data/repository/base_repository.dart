import 'package:async/async.dart';
import 'package:logging/logging.dart';

import '../../core/error/exception.dart';

mixin BaseRepository {
  static const logTag = 'BaseRepository';
  DataException transformError(dynamic error) {
    Logger(logTag).severe('Handling error', error, StackTrace.current);
    if (error is DataException) {
      return error;
    } else {
      return UnknownDataException(cause: error);
    }
  }

  Stream<Result<T>> fetchFutureStream<T>(
    Future<Stream<Result<T>>> Function() call,
  ) async* {
    try {
      yield* await call();
    } catch (e) {
      yield Result.error(transformError(e));
    }
  }

  Stream<Result<T>> fetchStream<T>(
    Stream<Result<T>> Function() call,
  ) async* {
    try {
      yield* call();
    } catch (e) {
      yield Result.error(transformError(e));
    }
  }

  Future<Result<void>> doEmptyResult(
    Future<void> Function() call,
  ) async {
    try {
      await call();
      return Result.value(null);
    } catch (e) {
      return Result.error(transformError(e));
    }
  }
}
