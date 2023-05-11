import 'package:dio/dio.dart';
import 'package:logging/logging.dart';

import '../../../../core/error/data_exception.dart';

mixin BaseRetrofitDataStore {
  static const logTag = 'BaseRetrofitDataStore';

  DataException _transformError(dynamic error) {
    Logger(logTag).severe('Handling error: $error');
    if (error is DioException) {
      return _transformDioError(error);
    } else if (error is TypeError) {
      return DataException.invalidOutputFormat(cause: error);
    } else {
      return DataException.unknown(cause: error);
    }
  }

  DataException _transformDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return DataException.timeout(cause: error);
      case DioExceptionType.cancel:
        return DataException.canceled(cause: error);
      case DioExceptionType.badResponse:
        return _transformDioResponseError(error);
      case DioExceptionType.connectionError:
        return DataException.connectionError(cause: error);
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        return DataException.unknown(cause: error);
    }
  }

  DataException _transformDioResponseError(DioException error) {
    switch (error.response?.statusCode) {
      case 401:
        return DataException.unauthorized(cause: error);
      case 404:
        return DataException.notFound(cause: error);
      default:
        return DataException.unknown(cause: error);
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
