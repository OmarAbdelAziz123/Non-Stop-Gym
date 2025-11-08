import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:non_stop/app.dart';
import 'package:non_stop/config/app_initializer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// ✅ Initialize App Core Services
  await AppInitializer.init();

  runApp(
    EasyLocalization(
      saveLocale: true,
      useFallbackTranslations: true,
      fallbackLocale: const Locale('ar', 'EG'),
      startLocale: const Locale('ar', 'EG'),
      supportedLocales: const [Locale('ar', 'EG'), Locale('en', 'UK')],
      path: 'assets/languages',
      child: Phoenix(child: const MyApp()),
    ),
  );
}
