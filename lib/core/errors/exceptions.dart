/// 🔹 Represents different exceptions in the app
/// Can be thrown to indicate errors that should be caught by Failure handlers
abstract class AppException implements Exception {
  final String message;

  const AppException(this.message);

  @override
  String toString() => message;
}

/// 🔸 Exception when network request fails
class NetworkException extends AppException {
  final int? statusCode;

  const NetworkException(super.message, {this.statusCode});

  @override
  String toString() => 'NetworkException(statusCode: $statusCode, message: $message)';
}

/// 🔸 Exception when local storage operation fails
class CacheException extends AppException {
  const CacheException(super.message);

  @override
  String toString() => 'CacheException(message: $message)';
}

/// 🔸 Generic or unknown exception
class UnknownException extends AppException {
  const UnknownException(super.message);

  @override
  String toString() => 'UnknownException(message: $message)';
}
