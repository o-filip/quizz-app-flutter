import 'package:async/async.dart';

extension ResultExt<T> on Result<T> {
  Result<R> map<R>({
    required R Function(T value) value,
    Object Function(Object error)? error,
  }) {
    if (isValue) {
      return Result.value(value((this as ValueResult<T>).value));
    } else {
      return Result.error(error?.call((this as ErrorResult).error) ??
          (this as ErrorResult).error);
    }
  }

  Result<R> mapCatching<R>({
    required R Function(T value) value,
    Object Function(Object error)? error,
  }) {
    try {
      if (isValue) {
        return Result.value(value((this as ValueResult<T>).value));
      } else {
        return Result.error(error?.call((this as ErrorResult).error) ??
            (this as ErrorResult).error);
      }
    } catch (e) {
      return Result.error(e);
    }
  }

  void when<R>({
    required void Function(T value) value,
    required void Function(Object error) error,
  }) {
    if (isValue) {
      value((this as ValueResult<T>).value);
    } else {
      error((this as ErrorResult).error);
    }
  }
}
