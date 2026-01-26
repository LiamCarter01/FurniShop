/// Base class for all exceptions in the application.
///
/// Use this for exceptions that occur in data layer.
abstract class AppException implements Exception {
  final String message;
  final int? code;

  const AppException({
    required this.message,
    this.code,
  });

  @override
  String toString() => 'AppException: $message (code: $code)';
}

/// Exception for server-related errors.
class ServerException extends AppException {
  const ServerException({
    super.message = 'Server error occurred',
    super.code,
  });
}

/// Exception for network-related errors.
class NetworkException extends AppException {
  const NetworkException({
    super.message = 'Network error occurred',
    super.code,
  });
}

/// Exception for cache-related errors.
class CacheException extends AppException {
  const CacheException({
    super.message = 'Cache error occurred',
    super.code,
  });
}

/// Exception for parsing errors.
class ParseException extends AppException {
  const ParseException({
    super.message = 'Failed to parse data',
    super.code,
  });
}

/// Exception for not found errors.
class NotFoundException extends AppException {
  const NotFoundException({
    super.message = 'Resource not found',
    super.code = 404,
  });
}

/// Exception for unauthorized access.
class UnauthorizedException extends AppException {
  const UnauthorizedException({
    super.message = 'Unauthorized access',
    super.code = 401,
  });
}
