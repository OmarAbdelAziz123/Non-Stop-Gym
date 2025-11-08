import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// App-wide constants that do not depend on the environment.
/// Use [EnvConfig] and [AppFlavor] for environment-specific values.
class AppConstants {
  /// 🔹 Global navigator key for navigation or localization outside widget tree.
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// 🔹 App info
  static const String appName = 'Non Stop';
  static const String appVersion = '1.0.0';


  /// 🔹 SharedPreferences / SecureStorage keys
  static const String accessTokenKey = 'ACCESS_TOKEN';
  static const String refreshTokenKey = 'REFRESH_TOKEN';
  static const String userIdKey = 'USER_ID';
  static const String fcmTokenKey = 'FCM_TOKEN';

  /// 🔹 Supported locales
  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('ar'),
  ];

  /// 🔹 Default locale
  static const Locale defaultLocale = Locale('ar');

  /// 🔹 Helper to get current BuildContext safely
  static BuildContext get context => navigatorKey.currentContext!;

  /// 🔹 Helper to access current locale anywhere
  static Locale get currentLocale => Localizations.localeOf(context);

  /// 🔹 Helper to check if current language is Arabic
  static bool get isArabic => currentLocale.languageCode == 'ar';
}
