import 'package:dio/dio.dart';
import '../errors/errors.dart';
import '../services/logger_service.dart';

/// Logging Interceptor - logs HTTP requests and responses in debug mode
class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.info('📤 REQUEST: ${options.method} ${options.path}');
    logger.info('Headers: ${options.headers}');
    if (options.data != null) {
      logger.info('Body: ${options.data}');
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.info(
      '📥 RESPONSE: ${response.statusCode} ${response.requestOptions.path}',
    );
    logger.info('Data: ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger.error('❌ ERROR: ${err.message}');
    logger.error('Type: ${err.type}');
    super.onError(err, handler);
  }
}

/// Authorization Interceptor - handles token injection and refresh
class AuthorizationInterceptor extends Interceptor {
  final String? accessToken;

  AuthorizationInterceptor({this.accessToken});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Add authorization header if token exists
    if (accessToken != null && accessToken!.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Handle 401 Unauthorized - Token expired or invalid
    if (err.response?.statusCode == 401) {
      logger.warning('⚠️ Token expired or invalid - 401 received');
      // TODO: Implement token refresh logic
      // - Attempt to refresh token
      // - If refresh fails, redirect to login
      // - Retry original request with new token
    }
    super.onError(err, handler);
  }
}

/// Error Interceptor - converts DioException to custom exceptions
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final exception = _mapDioExceptionToException(err);
    logger.error('Mapped exception: ${exception.runtimeType}');
    handler.reject(err);
  }

  /// Maps DioException to custom exceptions
  Exception _mapDioExceptionToException(DioException dioException) {
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
          message: 'Network connection failed. Please check your internet.',
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

  /// Maps HTTP status codes to specific exceptions
  Exception _mapHttpException(DioException dioException) {
    final statusCode = dioException.response?.statusCode;
    final message =
        dioException.response?.data?['message'] as String? ??
        'HTTP Error $statusCode';

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
          message: 'Access forbidden. You do not have permission.',
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
          message: 'Conflict. Resource already exists.',
          statusCode: statusCode,
          originalException: dioException,
        );

      case 422:
        return ServerException(
          message: 'Validation error. Please check your input.',
          statusCode: statusCode,
          originalException: dioException,
        );

      case 429:
        return ServerException(
          message: 'Too many requests. Please try again later.',
          statusCode: statusCode,
          originalException: dioException,
        );

      case 500:
      case 502:
      case 503:
      case 504:
        return ServerException(
          message: 'Server error. Please try again later.',
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
