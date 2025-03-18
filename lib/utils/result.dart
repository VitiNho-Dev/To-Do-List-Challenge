import 'errors/custom_errors.dart';

sealed class Result<T> {
  const Result();

  factory Result.ok(T value) = Ok._;

  factory Result.error(Failure value) = Error._;
}

final class Ok<T> extends Result<T> {
  final T value;

  const Ok._(this.value);
}

final class Error<T> extends Result<T> {
  final Failure error;

  const Error._(this.error);
}
