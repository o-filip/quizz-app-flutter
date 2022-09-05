import 'package:logging/logging.dart';

import '../../../../core/error/data_exception.dart';

mixin BaseDriftLocalDataStore {
  static const logTag = 'BaseDriftLocalDataStore';

  DataException _transformError(dynamic error) {
    Logger(logTag).severe('Handling error: $error');
    return DataException.unknown(cause: error);
  }

  Stream<T> driftFetch<T>(
    Stream<T> Function() call,
  ) async* {
    try {
      yield* call();
    } catch (ex) {
      throw _transformError(ex);
    }
  }

  Future<void> driftDo(
    Future<void> Function() call,
  ) async {
    try {
      return await call();
    } catch (ex) {
      throw _transformError(ex);
    }
  }
}
