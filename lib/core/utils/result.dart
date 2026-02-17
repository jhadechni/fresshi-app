/// A sealed Result type for type-safe error handling.
/// Use [Result.ok] for success and [Result.error] for failure.
///
/// Example:
/// ```dart
/// Future<Result<String>> fetchName() async {
///   try {
///     return Result.ok('Fresshi');
///   } catch (e) {
///     return Result.error(e);
///   }
/// }
///
/// final result = await fetchName();
/// switch (result) {
///   case Ok(:final value): print(value);
///   case Error(:final error): print(error);
/// }
/// ```
sealed class Result<T> {
  const Result();

  factory Result.ok(T value) => Ok(value);
  factory Result.error(Object error) => Error(error);

  bool get isOk => this is Ok<T>;
  bool get isError => this is Error<T>;

  Ok<T> get asOk => this as Ok<T>;
  Error<T> get asError => this as Error<T>;

  R when<R>({
    required R Function(T value) ok,
    required R Function(Object error) onError,
  }) {
    return switch (this) {
      Ok(:final value) => ok(value),
      Error(:final error) => onError(error),
    };
  }
}

final class Ok<T> extends Result<T> {
  final T value;
  const Ok(this.value);
}

final class Error<T> extends Result<T> {
  final Object error;
  const Error(this.error);
}
