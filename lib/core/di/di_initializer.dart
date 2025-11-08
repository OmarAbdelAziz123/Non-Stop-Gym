import 'injection_container.dart';

class DIInitializer {
  /// 🟢 Singleton instance
  static final DIInitializer instance = DIInitializer._internal();

  factory DIInitializer() => instance;

  DIInitializer._internal();

  /// 🟢 init method
  Future<void> init() async {
    await initDependencies();
  }
}
