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

  DataException _transformDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutDataException(cause: error);
      case DioExceptionType.cancel:
        return CanceledDataException(cause: error);
      case DioExceptionType.badResponse:
        return _transformDioResponseError(error);
      case DioExceptionType.connectionError:
        return ConnectionErrorDataException(cause: error);
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        return UnknownDataException(cause: error);
    }
  }

  DataException _transformDioResponseError(DioException error) {
    switch (error.response?.statusCode) {
      case 401:
        return UnauthorizedDataException(cause: error);
      case 404:
        return NotFoundDataException(cause: error);
      default:
        return UnknownDataException(cause: error);
    }
  }

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
