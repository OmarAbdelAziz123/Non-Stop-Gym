import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:non_stop/firebase_options.dart';

class FirebaseService {
  // 🟢 Singleton instance
  static final FirebaseService instance = FirebaseService._internal();

  factory FirebaseService() => instance;
  FirebaseService._internal();

  /// 🧩 Initialize Firebase safely
  Future<void> init() async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      log('🔥 Firebase initialized successfully');
    } catch (e, stack) {
      log('❌ Firebase initialization failed: $e', stackTrace: stack);
      rethrow; // لو حبيت تمسكها فوق في AppInitializer
    }
  }
}
