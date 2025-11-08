import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// SecureStorage
/// --------------
/// A service class that provides encrypted key-value storage
/// using flutter_secure_storage.
/// Designed for sensitive data such as tokens, credentials, etc.
///
/// ✅ Example:
/// ```dart
/// final secure = SecureStorage();
/// await secure.write('access_token', 'xyz123');
/// final token = await secure.read('access_token');
/// ```
class SecureStorage {
  // Singleton pattern for global usage
  static final SecureStorage _instance = SecureStorage._internal();
  factory SecureStorage() => _instance;
  SecureStorage._internal();

  // Instance of FlutterSecureStorage
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  /// Write a secure key-value pair
  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  /// Read a value by key
  Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }

  /// Delete a specific key
  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  /// Delete all stored values (use with caution)
  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }

  /// Check if key exists
  Future<bool> containsKey(String key) async {
    return await _storage.containsKey(key: key);
  }

  /// Read all keys and values (for debugging or admin tools)
  Future<Map<String, String>> readAll() async {
    return await _storage.readAll();
  }
}
