import 'dart:developer';
import 'package:non_stop/core/network/endpoints.dart';
import 'package:non_stop/core/services/firebase_service.dart';
import '../core/services/local_storage.dart';
import '../core/services/notification_service.dart';

class AppInitializer {
  static Future<void> init() async {

    /// 2️⃣ Initialize Firebase (SDK-level initialization)
    await FirebaseService.instance.init();

    /// 3️⃣ Initialize Local Storage
    await LocalStorageService.instance.init();

    /// 4️⃣ Initialize Notification Service
    await NotificationService.instance.init();

    final storage = LocalStorageService();

    final fcmToken = await storage.get<String>(EndPoints.fcmTokenKey);
    final accessToken = await storage.get<String>(EndPoints.accessTokenKey);

    log("🎉 App initialized successfully");
    log("📱 FCM Token: $fcmToken");
    log("🔑 Access token: $accessToken");
  }
}