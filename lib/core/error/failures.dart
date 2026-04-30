import 'package:equatable/equatable.dart';

/// Base failure class for domain layer errors
///
/// Failures are used in the domain layer with Either type
/// to represent error states without throwing exceptions.
sealed class Failure extends Equatable {
  const Failure({required this.message, this.code});

  final String message;
  final String? code;

  @override
  List<Object?> get props => [message, code];

  @override
  String toString() =>
      'Failure: $message${code != null ? ' (code: $code)' : ''}';
}

/// Server failure for API errors
final class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.code, this.statusCode});

  final int? statusCode;

  @override
  List<Object?> get props => [message, code, statusCode];

  /// Common server failure factory methods
  factory ServerFailure.unknown() => const ServerFailure(
    message: 'An unexpected error occurred',
    code: 'UNKNOWN_ERROR',
  );

  factory ServerFailure.notFound() => const ServerFailure(
    message: 'Resource not found',
    code: 'NOT_FOUND',
    statusCode: 404,
  );

  factory ServerFailure.internalError() => const ServerFailure(
    message: 'Internal server error',
    code: 'INTERNAL_ERROR',
    statusCode: 500,
  );

  factory ServerFailure.serviceUnavailable() => const ServerFailure(
    message: 'Service temporarily unavailable',
    code: 'SERVICE_UNAVAILABLE',
    statusCode: 503,
  );
}

/// Cache failure for local storage errors
final class CacheFailure extends Failure {
  const CacheFailure({required super.message, super.code});

  factory CacheFailure.notFound() => const CacheFailure(
    message: 'Data not found in cache',
    code: 'CACHE_NOT_FOUND',
  );

  factory CacheFailure.expired() => const CacheFailure(
    message: 'Cached data has expired',
    code: 'CACHE_EXPIRED',
  );

  factory CacheFailure.writeError() => const CacheFailure(
    message: 'Failed to write to cache',
    code: 'CACHE_WRITE_ERROR',
  );
}

/// Network failure for connectivity issues
final class NetworkFailure extends Failure {
  const NetworkFailure({
    super.message = 'No internet connection',
    super.code = 'NETWORK_ERROR',
  });

  factory NetworkFailure.noConnection() => const NetworkFailure();

  factory NetworkFailure.timeout() =>
      const NetworkFailure(message: 'Connection timed out', code: 'TIMEOUT');

  factory NetworkFailure.connectionRefused() => const NetworkFailure(
    message: 'Connection refused',
    code: 'CONNECTION_REFUSED',
  );
}

/// Authentication failure for auth-related errors
final class AuthFailure extends Failure {
  const AuthFailure({required super.message, super.code});

  factory AuthFailure.unauthorized() =>
      const AuthFailure(message: 'Unauthorized access', code: 'UNAUTHORIZED');

  factory AuthFailure.tokenExpired() => const AuthFailure(
    message: 'Session expired. Please log in again',
    code: 'TOKEN_EXPIRED',
  );

  factory AuthFailure.invalidCredentials() => const AuthFailure(
    message: 'Invalid email or password',
    code: 'INVALID_CREDENTIALS',
  );

  factory AuthFailure.accountLocked() => const AuthFailure(
    message: 'Account has been locked',
    code: 'ACCOUNT_LOCKED',
  );
}

/// Validation failure for input validation errors
final class ValidationFailure extends Failure {
  const ValidationFailure({required super.message, super.code, this.errors});

  /// Field-specific validation errors
  final Map<String, List<String>>? errors;

  @override
  List<Object?> get props => [message, code, errors];

  factory ValidationFailure.invalidInput([String? field]) => ValidationFailure(
    message: field != null ? 'Invalid $field' : 'Invalid input',
    code: 'VALIDATION_ERROR',
  );

  factory ValidationFailure.requiredField(String field) =>
      ValidationFailure(message: '$field is required', code: 'REQUIRED_FIELD');
}

/// Permission failure for permission-related errors
final class PermissionFailure extends Failure {
  const PermissionFailure({
    required super.message,
    super.code,
    this.permission,
  });

  final String? permission;

  @override
  List<Object?> get props => [message, code, permission];

  factory PermissionFailure.denied(String permission) => PermissionFailure(
    message: '$permission permission denied',
    code: 'PERMISSION_DENIED',
    permission: permission,
  );

  factory PermissionFailure.permanentlyDenied(
    String permission,
  ) => PermissionFailure(
    message:
        '$permission permission permanently denied. Please enable in settings',
    code: 'PERMISSION_PERMANENTLY_DENIED',
    permission: permission,
  );
}
