import 'package:equatable/equatable.dart';

/// Base failure class for domain layer
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

/// Server/API error failure
class ServerFailure extends Failure {
  final int? statusCode;

  const ServerFailure(super.message, {this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}

/// Network connectivity failure
class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

/// Cache operation failure
class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

/// Request timeout failure
class TimeoutFailure extends Failure {
  const TimeoutFailure(super.message);
}

/// 401 Unauthorized failure
class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure(super.message);
}

/// 403 Forbidden failure
class ForbiddenFailure extends Failure {
  const ForbiddenFailure(super.message);
}

/// Unknown/unhandled failure
class UnknownFailure extends Failure {
  const UnknownFailure(super.message);
}
