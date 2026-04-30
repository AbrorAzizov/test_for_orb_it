/// Base exception class for application exceptions
///
/// All custom exceptions should extend this class.
sealed class AppException implements Exception {
  const AppException({required this.message, this.code, this.stackTrace});

  final String message;
  final String? code;
  final StackTrace? stackTrace;

  @override
  String toString() =>
      'AppException: $message${code != null ? ' (code: $code)' : ''}';
}

/// Server exception for API errors
final class ServerException extends AppException {
  const ServerException({
    required super.message,
    super.code,
    super.stackTrace,
    this.statusCode,
    this.response,
  });

  final int? statusCode;
  final dynamic response;

  @override
  String toString() => 'ServerException: $message (status: $statusCode)';
}

/// Cache exception for local storage errors
final class CacheException extends AppException {
  const CacheException({required super.message, super.code, super.stackTrace});

  @override
  String toString() => 'CacheException: $message';
}

/// Network exception for connectivity issues
final class NetworkException extends AppException {
  const NetworkException({
    super.message = 'No internet connection',
    super.code,
    super.stackTrace,
  });

  @override
  String toString() => 'NetworkException: $message';
}

/// Unauthorized exception for authentication errors
final class UnauthorizedException extends AppException {
  const UnauthorizedException({
    super.message = 'Unauthorized access',
    super.code,
    super.stackTrace,
  });

  @override
  String toString() => 'UnauthorizedException: $message';
}

/// Validation exception for input validation errors
final class ValidationException extends AppException {
  const ValidationException({
    required super.message,
    super.code,
    super.stackTrace,
    this.errors,
  });

  /// Field-specific validation errors
  final Map<String, List<String>>? errors;

  @override
  String toString() => 'ValidationException: $message';
}

/// Timeout exception for request timeouts
final class TimeoutException extends AppException {
  const TimeoutException({
    super.message = 'Request timed out',
    super.code,
    super.stackTrace,
  });

  @override
  String toString() => 'TimeoutException: $message';
}

/// Format exception for data parsing errors
final class FormatException extends AppException {
  const FormatException({
    required super.message,
    super.code,
    super.stackTrace,
    this.source,
  });

  final dynamic source;

  @override
  String toString() => 'FormatException: $message';
}

/// Permission exception for permission-related errors
final class PermissionException extends AppException {
  const PermissionException({
    required super.message,
    super.code,
    super.stackTrace,
    this.permission,
  });

  final String? permission;

  @override
  String toString() => 'PermissionException: $message';
}
