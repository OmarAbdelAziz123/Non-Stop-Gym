import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:non_stop/common/widgets/notification_snack_bar.dart';
import 'package:non_stop/core/constants/app_constants.dart';
import 'package:non_stop/core/network/endpoints.dart';
import 'package:non_stop/core/services/local_storage.dart';

/// Handles background notifications
Future<void> handleBackgroundMessage(RemoteMessage message) async {
  log("📩 Background message received: ${message.notification?.title}");
}

/// Centralized notification manager for both local and push notifications
class NotificationService {
  // 🧠 Singleton Pattern
  static final NotificationService instance = NotificationService._internal();
  factory NotificationService() => instance;
  NotificationService._internal();

  // 🔹 Firebase Messaging instance
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  // 🔹 Local Notifications instance
  final FlutterLocalNotificationsPlugin _localNotifications =
  FlutterLocalNotificationsPlugin();

  // 🔹 Cached FCM token
  String? fcmToken;

  /// Alias for [initialize] — optional convenience method
  Future<void> init() async => await initialize();

  /// Initializes everything related to notifications
  Future<void> initialize() async {
    try {
      log("🚀 Initializing NotificationService...");

      await _initLocalNotifications();
      await _requestPermissions();
      await _initPushNotifications();

      // Get FCM Token
      fcmToken = await _fcm.getToken();

      // ✅ Store token securely
      final storage = LocalStorageService();
      await storage.set<String>(EndPoints.fcmTokenKey, fcmToken ?? '');

      log("✅ NotificationService initialized successfully");
      log("📱 FCM Token: $fcmToken");

      /// 🔁 Listen for token refresh (important for long-term stability)
      FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
        log("🔄 FCM Token refreshed: $newToken");
        fcmToken = newToken;
        await storage.set<String>(EndPoints.fcmTokenKey, newToken);
      });
    } catch (e, stack) {
      log("❌ NotificationService initialization failed: $e");
      log("🧩 StackTrace: $stack");
    }
  }

  /// Initialize local notifications (FlutterLocalNotificationsPlugin)
  Future<void> _initLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidSettings);

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        log("🔔 Local notification tapped with payload: ${response.payload}");
      },
    );

    const channel = AndroidNotificationChannel(
      'default_channel',
      'Default',
      description: 'Default notification channel',
      importance: Importance.high,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    log("📦 Local notifications initialized successfully");
  }

  /// Request permissions for Android & iOS
  Future<void> _requestPermissions() async {
    try {
      if (Platform.isAndroid) {
        await _localNotifications
            .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
            ?.requestNotificationsPermission();
        log("🔓 Android notifications permission granted");
      }

      if (Platform.isIOS) {
        await _localNotifications
            .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
            ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
          critical: false,
          provisional: false,
        );
        log("🔓 iOS notifications permission granted");
      }

      await _fcm.requestPermission();
    } catch (e) {
      log("⚠️ Notification permission request failed: $e");
    }
  }

  /// Initialize Firebase Push Notifications listeners
  Future<void> _initPushNotifications() async {
    try {
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      // Foreground notifications
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        _handleMessage(message);

        final notification = message.notification;
        if (notification != null) {
          NotificationSnackBar.show(
            context: AppConstants.navigatorKey.currentContext!,
            title: notification.title ?? 'New Notification',
            remoteMessage: message,
          );
        }
      });

      // When app is opened from a notification
      FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);

      log("📡 Firebase Push Notifications initialized successfully");
    } catch (e) {
      log("❌ Push notifications initialization failed: $e");
    }
  }

  /// Handle and show local notifications when receiving push notifications
  void _handleMessage(RemoteMessage? message) {
    if (message == null) return;

    final notification = message.notification;
    if (notification == null) return;

    log("📨 Received push notification: ${notification.title}");

    _localNotifications.show(
      notification.hashCode,
      notification.title,
      notification.body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'default_channel',
          'Default',
          channelDescription: 'Default channel for general notifications',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
  }
}
