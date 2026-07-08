/// Global exception base class for server errors
class ServerException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic originalException;

  ServerException({
    required this.message,
    this.statusCode,
    this.originalException,
  });

  @override
  String toString() => 'ServerException: $message (Status: $statusCode)';
}

/// Global exception for network connectivity errors
class NetworkException implements Exception {
  final String message;
  final dynamic originalException;

  NetworkException({required this.message, this.originalException});

  @override
  String toString() => 'NetworkException: $message';
}

/// Global exception for request timeout
class TimeoutException implements Exception {
  final String message;
  final dynamic originalException;

  TimeoutException({required this.message, this.originalException});

  @override
  String toString() => 'TimeoutException: $message';
}

/// Global exception for cache errors
class CacheException implements Exception {
  final String message;
  final dynamic originalException;

  CacheException({required this.message, this.originalException});

  @override
  String toString() => 'CacheException: $message';
}

/// Global exception for 401 Unauthorized
class UnauthorizedException implements Exception {
  final String message;
  final dynamic originalException;

  UnauthorizedException({required this.message, this.originalException});

  @override
  String toString() => 'UnauthorizedException: $message';
}

/// Global exception for 403 Forbidden
class ForbiddenException implements Exception {
  final String message;
  final dynamic originalException;

  ForbiddenException({required this.message, this.originalException});

  @override
  String toString() => 'ForbiddenException: $message';
}

/// Global exception for unknown/unhandled errors
class UnknownException implements Exception {
  final String message;
  final dynamic originalException;

  UnknownException({required this.message, this.originalException});

  @override
  String toString() => 'UnknownException: $message';
}
