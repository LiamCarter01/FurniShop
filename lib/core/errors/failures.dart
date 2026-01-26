import 'package:equatable/equatable.dart';

/// Base class for all failures in the application.
///
/// Use this to represent errors that occur during data operations.
/// All specific failure types should extend this class.
abstract class Failure extends Equatable {
  final String message;
  final int? code;

  const Failure({
    required this.message,
    this.code,
  });

  @override
  List<Object?> get props => [message, code];
}

/// Failure for server-related errors.
///
/// Use when API calls fail due to server issues.
class ServerFailure extends Failure {
  const ServerFailure({
    super.message = 'Server error occurred. Please try again later.',
    super.code,
  });
}

/// Failure for network-related errors.
///
/// Use when there's no internet connection or network issues.
class NetworkFailure extends Failure {
  const NetworkFailure({
    super.message = 'Network error. Please check your internet connection.',
    super.code,
  });
}

/// Failure for cache-related errors.
///
/// Use when local storage operations fail.
class CacheFailure extends Failure {
  const CacheFailure({
    super.message = 'Cache error occurred.',
    super.code,
  });
}

/// Failure for validation errors.
///
/// Use when input validation fails.
class ValidationFailure extends Failure {
  const ValidationFailure({
    required super.message,
    super.code,
  });
}

/// Failure for not found errors.
///
/// Use when requested resource doesn't exist.
class NotFoundFailure extends Failure {
  const NotFoundFailure({
    super.message = 'Resource not found.',
    super.code = 404,
  });
}

/// Failure for unauthorized access.
///
/// Use when user is not authorized to perform an action.
class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({
    super.message = 'Unauthorized access. Please login again.',
    super.code = 401,
  });
}

/// Failure for unexpected errors.
///
/// Use as a fallback for unknown errors.
class UnexpectedFailure extends Failure {
  const UnexpectedFailure({
    super.message = 'An unexpected error occurred.',
    super.code,
  });
}
