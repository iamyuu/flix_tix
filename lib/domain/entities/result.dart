sealed class Result<T> {
  const Result();

  const factory Result.success(T value) = Success<T>;
  const factory Result.error(String message) = Error<T>;

  bool get isSuccess => this is Success<T>;
  bool get isError => this is Error<T>;

  T? get data => isSuccess ? (this as Success<T>).value : null;
  String? get error => isError ? (this as Error<T>).message : null;
}

class Success<T> extends Result<T> {
  final T value;

  const Success(this.value);
}

class Error<T> extends Result<T> {
  final String message;

  const Error(this.message);
}
