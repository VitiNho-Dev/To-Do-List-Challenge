final class ApiError implements Exception {
  final String message;
  final int? statusCode;

  const ApiError({required this.message, required this.statusCode});
}

final class ClientHttpError implements Exception {
  final String message;
  final StackTrace? stackTrace;

  const ClientHttpError({required this.message, this.stackTrace});
}

final class UnexpectedError implements Exception {
  final String message;
  final StackTrace? stackTrace;

  const UnexpectedError({required this.message, this.stackTrace});
}

final class RepositoryError implements Exception {
  final String message;
  final StackTrace? stackTrace;

  const RepositoryError({required this.message, this.stackTrace});
}
