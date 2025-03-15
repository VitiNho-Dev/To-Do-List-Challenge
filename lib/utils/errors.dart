abstract interface class Error implements Exception {
  final String message;
  final StackTrace? stackTrace;

  const Error({this.message = 'Error', this.stackTrace});
}

class ErrorMessages {
  /// Erro no servidor:
  static const onServer = "Erro no servidor:";

  /// Erro inesperado:
  static const unexpected = "Erro inesperado:";
}

final class HttpException implements Error {
  @override
  final String message;
  final int statusCode;
  @override
  final StackTrace? stackTrace;

  const HttpException({
    required this.message,
    required this.statusCode,
    this.stackTrace,
  });
}

final class UnexpectedError implements Error {
  @override
  final String message;
  @override
  final StackTrace? stackTrace;

  const UnexpectedError({required this.message, this.stackTrace});
}

final class RepositoryError implements Error {
  @override
  final String message;
  @override
  final StackTrace? stackTrace;

  const RepositoryError({required this.message, this.stackTrace});
}
