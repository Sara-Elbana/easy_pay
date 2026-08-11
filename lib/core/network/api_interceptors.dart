import 'package:dio/dio.dart';
import 'package:easy_pay_app/core/constants/api_constants.dart';
import 'package:easy_pay_app/core/di/service_locator.dart';
import 'package:easy_pay_app/core/services/secure_storage_service.dart';

import '../errors/errors.dart';
import '../services/logger_service.dart';

/// ===============================================================
/// Logging Interceptor
/// ===============================================================
/// Responsible for logging API requests, responses, and errors.
///
/// IMPORTANT:
/// Sensitive information is sanitized before being logged.
/// This prevents passwords, tokens, card numbers, etc. from
/// appearing in the application logs.
/// ===============================================================
class LoggingInterceptor extends Interceptor {
  static const Set<String> _sensitiveKeys = {
    'password',
    'token',
    'access_token',
    'refresh_token',
    'authorization',
    'card_number',
    'account_number',
    'pin',
    'otp',
    'cvv',
    'secret',
    'client_secret',
  };

  /// Sanitizes sensitive data before logging it.
  dynamic _sanitizeData(dynamic data) {
    if (data is Map) {
      final result = <String, dynamic>{};

      for (final entry in data.entries) {
        final key = entry.key.toString();
        final normalizedKey = key.toLowerCase();

        if (_sensitiveKeys.contains(normalizedKey)) {
          result[key] = '***REDACTED***';
        } else {
          result[key] = _sanitizeData(entry.value);
        }
      }

      return result;
    }

    if (data is List) {
      return data.map(_sanitizeData).toList();
    }

    return data;
  }

  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) {
    logger.info(
      '📤 REQUEST: ${options.method} ${options.path}',
    );

    // Sanitize headers before logging.
    logger.info(
      'Headers: ${_sanitizeData(options.headers)}',
    );

    // Sanitize request body before logging.
    if (options.data != null) {
      logger.info(
        'Body: ${_sanitizeData(options.data)}',
      );
    }

    // Sanitize query parameters before logging.
    if (options.queryParameters.isNotEmpty) {
      logger.info(
        'Query: ${_sanitizeData(options.queryParameters)}',
      );
    }

    handler.next(options);
  }

  @override
  void onResponse(
      Response response,
      ResponseInterceptorHandler handler,
      ) {
    logger.info(
      '📥 RESPONSE: ${response.statusCode} '
          '${response.requestOptions.path}',
    );

    // Sanitize response data before logging.
    logger.info(
      'Data: ${_sanitizeData(response.data)}',
    );

    handler.next(response);
  }

  @override
  void onError(
      DioException err,
      ErrorInterceptorHandler handler,
      ) {
    logger.error(
      '❌ ERROR: ${err.message}',
    );

    logger.error(
      'Type: ${err.type}',
    );

    logger.error(
      'Status Code: ${err.response?.statusCode}',
    );

    // Sanitize error response before logging.
    if (err.response?.data != null) {
      logger.error(
        'Response: ${_sanitizeData(err.response?.data)}',
      );
    }

    handler.next(err);
  }
}

/// ===============================================================
/// Authorization Interceptor
/// ===============================================================
/// Responsible for:
/// 1. Adding the access token to requests.
/// 2. Handling 401 responses.
/// 3. Refreshing the access token.
/// 4. Retrying the failed request.
/// ===============================================================
class AuthorizationInterceptor extends Interceptor {
  final String? accessToken;

  AuthorizationInterceptor({
    this.accessToken,
  });

  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    try {
      final secureStorage = getIt<SecureStorageService>();

      final storedToken = await secureStorage.getAccessToken();

      final token = (storedToken != null && storedToken.isNotEmpty)
          ? storedToken
          : accessToken;

      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    } catch (e) {
      logger.error(
        'Failed to retrieve access token from secure storage.',
      );
    }

    handler.next(options);
  }

  @override
  void onError(
      DioException err,
      ErrorInterceptorHandler handler,
      ) async {
    // Handle unauthorized requests.
    if (err.response?.statusCode == 401) {
      logger.warning(
        '⚠️ Token expired or invalid - 401 received',
      );

      final secureStorage = getIt<SecureStorageService>();

      try {
        final refreshToken = await secureStorage.getRefreshToken();

        if (refreshToken != null && refreshToken.isNotEmpty) {
          logger.info(
            '🔄 Attempting to refresh access token...',
          );

          // Use a separate Dio instance so we don't trigger
          // the same interceptors again.
          final refreshDio = Dio(
            BaseOptions(
              baseUrl: ApiConstants.baseUrl,
              contentType: ApiConstants.contentTypeJson,
              headers: {
                'Content-Type': ApiConstants.contentTypeJson,
              },
            ),
          );

          final response = await refreshDio.post(
            ApiConstants.refreshTokenEndpoint,
            data: {
              'refresh_token': refreshToken,
            },
          );

          if (response.statusCode == 200 ||
              response.statusCode == 201) {
            final newAccessToken =
            response.data['access_token'] as String?;

            final newRefreshToken =
            response.data['refresh_token'] as String?;

            if (newAccessToken != null &&
                newAccessToken.isNotEmpty) {
              await secureStorage.saveAccessToken(
                newAccessToken,
              );

              if (newRefreshToken != null &&
                  newRefreshToken.isNotEmpty) {
                await secureStorage.saveRefreshToken(
                  newRefreshToken,
                );
              }

              logger.info(
                '✅ Access token refreshed successfully',
              );

              // Retry original request with the new token.
              final requestOptions = err.requestOptions;

              requestOptions.headers['Authorization'] =
              'Bearer $newAccessToken';

              final retryDio = Dio();

              final retryResponse =
              await retryDio.fetch(requestOptions);

              return handler.resolve(retryResponse);
            }
          }

          logger.warning(
            '⚠️ Token refresh failed',
          );
        }

        // No refresh token available.
        logger.warning(
          '⚠️ No valid refresh token found',
        );

        await secureStorage.clearSensitiveData();
      } catch (e) {
        // NEVER log the actual token or sensitive response here.
        logger.error(
          '❌ Token refresh failed',
        );

        await secureStorage.clearSensitiveData();
      }
    }

    handler.next(err);
  }
}

/// ===============================================================
/// Error Interceptor
/// ===============================================================
/// Converts DioException into application-specific exceptions.
/// ===============================================================
class ErrorInterceptor extends Interceptor {
  @override
  void onError(
      DioException err,
      ErrorInterceptorHandler handler,
      ) {
    final exception = _mapDioExceptionToException(err);

    logger.error(
      'Mapped exception: ${exception.runtimeType}',
    );

    final modifiedError = err.copyWith(
      error: exception,
    );

    handler.reject(modifiedError);
  }

  /// Maps Dio exceptions to application exceptions.
  Exception _mapDioExceptionToException(
      DioException dioException,
      ) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return TimeoutException(
          message: 'Request timeout. Please try again.',
          originalException: dioException,
        );

      case DioExceptionType.connectionError:
        return NetworkException(
          message:
          'Network connection failed. Please check your internet.',
          originalException: dioException,
        );

      case DioExceptionType.badResponse:
        return _mapHttpException(dioException);

      case DioExceptionType.cancel:
        return UnknownException(
          message: 'Request was cancelled',
          originalException: dioException,
        );

      case DioExceptionType.unknown:
        return UnknownException(
          message: 'An unknown error occurred',
          originalException: dioException,
        );

      default:
        return UnknownException(
          message: 'An unexpected error occurred',
          originalException: dioException,
        );
    }
  }

  /// Maps HTTP status codes to specific exceptions.
  Exception _mapHttpException(
      DioException dioException,
      ) {
    final statusCode = dioException.response?.statusCode;

    final responseData = dioException.response?.data;

    String message = 'HTTP Error $statusCode';

    if (responseData is Map &&
        responseData['message'] is String) {
      message = responseData['message'] as String;
    }

    switch (statusCode) {
      case 400:
        return ServerException(
          message: message,
          statusCode: statusCode,
          originalException: dioException,
        );

      case 401:
        return UnauthorizedException(
          message: 'Unauthorized. Please login again.',
          originalException: dioException,
        );

      case 403:
        return ForbiddenException(
          message:
          'Access forbidden. You do not have permission.',
          originalException: dioException,
        );

      case 404:
        return ServerException(
          message: 'Resource not found.',
          statusCode: statusCode,
          originalException: dioException,
        );

      case 409:
        return ServerException(
          message:
          'Conflict. Resource already exists.',
          statusCode: statusCode,
          originalException: dioException,
        );

      case 422:
        return ServerException(
          message: message,
          statusCode: statusCode,
          originalException: dioException,
        );

      case 429:
        return ServerException(
          message:
          'Too many requests. Please try again later.',
          statusCode: statusCode,
          originalException: dioException,
        );

      case 500:
      case 502:
      case 503:
      case 504:
        return ServerException(
          message:
          'Server error. Please try again later.',
          statusCode: statusCode,
          originalException: dioException,
        );

      default:
        return ServerException(
          message: message,
          statusCode: statusCode,
          originalException: dioException,
        );
    }
  }
}