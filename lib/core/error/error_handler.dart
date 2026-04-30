import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'exceptions.dart';
import 'failures.dart';

abstract final class ErrorHandler {
  static Failure handleException(dynamic exception, [StackTrace? stackTrace]) {
    _log(exception, stackTrace);

    return switch (exception) {
      ServerException e => ServerFailure(
        message: e.message,
        code: e.code,
        statusCode: e.statusCode,
      ),
      CacheException e => CacheFailure(message: e.message, code: e.code),
      NetworkException e => NetworkFailure(message: e.message, code: e.code),
      UnauthorizedException e => AuthFailure(message: e.message, code: e.code),
      ValidationException e => ValidationFailure(
        message: e.message,
        code: e.code,
        errors: e.errors,
      ),
      PermissionException e => PermissionFailure(
        message: e.message,
        code: e.code,
        permission: e.permission,
      ),
      DioException e => _handleDioException(e),
      _ => ServerFailure.unknown(),
    };
  }

  static Failure _handleDioException(DioException exception) {
    return switch (exception.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout => NetworkFailure.timeout(),
      DioExceptionType.connectionError => NetworkFailure.noConnection(),
      DioExceptionType.badResponse => _handleBadResponse(exception.response),
      DioExceptionType.cancel => const ServerFailure(
        message: 'Request was cancelled',
        code: 'REQUEST_CANCELLED',
      ),
      _ => ServerFailure.unknown(),
    };
  }

  static Failure _handleBadResponse(Response? response) {
    final statusCode = response?.statusCode;
    final data = response?.data;

    String message = 'An error occurred';
    String? code;

    if (data is Map<String, dynamic>) {
      message =
          data['message'] as String? ?? data['error'] as String? ?? message;
      code = data['code'] as String?;
    }

    return switch (statusCode) {
      400 => ValidationFailure(message: message, code: code ?? 'BAD_REQUEST'),
      401 => AuthFailure.unauthorized(),
      403 => const AuthFailure(message: 'Access forbidden', code: 'FORBIDDEN'),
      404 => ServerFailure.notFound(),
      409 => ServerFailure(
        message: message,
        code: code ?? 'CONFLICT',
        statusCode: 409,
      ),
      422 => ValidationFailure(message: message, code: code ?? 'UNPROCESSABLE'),
      429 => const ServerFailure(
        message: 'Too many requests. Please try again later',
        code: 'RATE_LIMITED',
        statusCode: 429,
      ),
      int sc when sc >= 500 => ServerFailure.internalError(),
      null => ServerFailure(message: message, code: code),
      _ => ServerFailure(message: message, code: code, statusCode: statusCode),
    };
  }

  static void _log(dynamic exception, StackTrace? stackTrace) {
    if (kDebugMode) {
      debugPrint('ErrorHandler: $exception');
      if (stackTrace != null) {
        debugPrint('StackTrace: $stackTrace');
      }
    }
  }

  static Future<T> runGuarded<T>(
    Future<T> Function() function, {
    T Function(Failure failure)? onError,
  }) async {
    try {
      return await function();
    } catch (e, stackTrace) {
      final failure = handleException(e, stackTrace);
      if (onError != null) {
        return onError(failure);
      }
      rethrow;
    }
  }

  static void setupErrorZone(void Function() appRunner) {
    runZonedGuarded(appRunner, (error, stackTrace) {
      _log(error, stackTrace);
    });
  }
}
