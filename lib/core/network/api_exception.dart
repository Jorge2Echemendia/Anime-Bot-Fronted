sealed class ApiException implements Exception {
  final String code;
  final String message;
  const ApiException(this.code, this.message);

  factory ApiException.fromJson(Map<String, dynamic> json) {
    final code = json['code'] as String? ?? 'UNKNOWN';
    final message = json['message'] as String? ?? 'Error desconocido';
    return switch (code) {
      'UNAUTHORIZED' => UnauthorizedException(message),
      'INVALID_CREDENTIALS' => InvalidCredentialsException(message),
      'USER_NOT_FOUND' => NotFoundException(message),
      'VALIDATION_ERROR' => ValidationException(message),
      _ => ServerException(code, message),
    };
  }
}

class UnauthorizedException extends ApiException {
  const UnauthorizedException(message) : super('UNAUTHORIZED', message);
}

class InvalidCredentialsException extends ApiException {
  const InvalidCredentialsException( message)
      : super('INVALID_CREDENTIALS', message);
}

class NotFoundException extends ApiException {
  const NotFoundException(message) : super('USER_NOT_FOUND', message);
}

class ValidationException extends ApiException {
  const ValidationException(message) : super('VALIDATION_ERROR', message);
}

class ServerException extends ApiException {
  const ServerException(super.code, super.message);
}

class NetworkException extends ApiException {
  const NetworkException(message) : super('NETWORK_ERROR', message);
}
