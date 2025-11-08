/// 🔹 Represents different types of failures in the app
/// This is a base class for all failures
abstract class Failure {
  final String message;

  const Failure(this.message);
}

/// 🔸 Failure when a network request fails
class NetworkFailure extends Failure {
  final int? statusCode;

  const NetworkFailure(super.message, {this.statusCode});

  @override
  String toString() => 'NetworkFailure(statusCode: $statusCode, message: $message)';
}

/// 🔸 Failure when local storage operation fails
class CacheFailure extends Failure {
  const CacheFailure(super.message);

  @override
  String toString() => 'CacheFailure(message: $message)';
}

/// 🔸 Generic or unknown failure
class UnknownFailure extends Failure {
  const UnknownFailure(super.message);

  @override
  String toString() => 'UnknownFailure(message: $message)';
}
