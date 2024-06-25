import 'package:dio/dio.dart';
import 'package:logging/logging.dart';

import '../../../../core/error/exception.dart';

mixin BaseRetrofitDataStore {
  static const logTag = 'BaseRetrofitDataStore';

  DataException _transformError(dynamic error) {
    Logger(logTag).severe('Handling error: $error');
    if (error is DioException) {
      return _transformDioError(error);
    } else if (error is TypeError) {
      return InvalidOutputFormatDataException(cause: error);
    } else {
      return UnknownDataException(cause: error);
    }
  }

  DataException _transformDioError(DioException error) => switch (error.type) {
        DioExceptionType.connectionTimeout ||
        DioExceptionType.sendTimeout ||
        DioExceptionType.receiveTimeout =>
          TimeoutDataException(cause: error),
        DioExceptionType.cancel => CanceledDataException(cause: error),
        DioExceptionType.badResponse => _transformDioResponseError(error),
        DioExceptionType.connectionError =>
          ConnectionErrorDataException(cause: error),
        DioExceptionType.badCertificate ||
        DioExceptionType.unknown =>
          UnknownDataException(cause: error),
      };

  DataException _transformDioResponseError(DioException error) =>
      switch (error.response?.statusCode) {
        401 => UnauthorizedDataException(cause: error),
        404 => NotFoundDataException(cause: error),
        _ => UnknownDataException(cause: error),
      };

  Future<T> fetch<T>(
    Future<T> Function() call,
  ) async {
    try {
      return await call();
    } catch (ex) {
      throw _transformError(ex);
    }
  }
}
