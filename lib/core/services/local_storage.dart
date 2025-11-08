import 'package:shared_preferences/shared_preferences.dart';
import 'secure_storage.dart';

/// LocalStorageService
/// Combines SharedPreferences + SecureStorage
/// Secure data → tokens, passwords
/// Normal data → theme, language, etc.
class LocalStorageService {
  // 🧠 Singleton Pattern
  static final LocalStorageService instance = LocalStorageService._internal();
  factory LocalStorageService() => instance;
  LocalStorageService._internal();

  // 🔹 Instances
  SharedPreferences? _prefs;
  final SecureStorage _secure = SecureStorage();

  /// Initialize SharedPreferences
  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  /// Generic getter
  Future<T?> get<T>(String key) async {
    return _prefs?.get(key) as T?;
  }

  /// Generic setter
  Future<void> set<T>(String key, T value) async {
    if (value is String) await _prefs?.setString(key, value);
    if (value is bool) await _prefs?.setBool(key, value);
    if (value is int) await _prefs?.setInt(key, value);
    if (value is double) await _prefs?.setDouble(key, value);
  }

  /// Secure write
  Future<void> secureWrite(String key, String value) async {
    await _secure.write(key, value);
  }

  /// Secure read
  Future<String?> secureRead(String key) async {
    return await _secure.read(key);
  }

  /// Remove key
  Future<void> remove(String key) async {
    await _prefs?.remove(key);
  }

  /// Clear all
  Future<void> clear() async {
    await _prefs?.clear();
    await _secure.deleteAll();
  }
}
