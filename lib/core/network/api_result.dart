abstract class ApiResult<T> {
  const ApiResult();
}

class ApiSuccess<T> extends ApiResult<T> {
  final T data;
  final String? message;

  const ApiSuccess({
    required this.data,
    this.message,
  });
}

class ApiFailure<T> extends ApiResult<T> {
  final String error;
  final String? message;

  const ApiFailure({
    required this.error,
    this.message,
  });
}
