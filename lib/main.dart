import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:non_stop/app.dart';
import 'package:non_stop/config/app_initializer.dart';
import 'package:non_stop/core/cache_helper/cache_helper.dart';
import 'package:non_stop/core/constants/app_constants.dart';
import 'package:non_stop/core/network/dio_helper/dio_helper.dart';
import 'package:non_stop/core/routing/app_router.dart';
import 'package:non_stop/core/services/di/dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize CacheHelper first to read saved language preference
  await CacheHelper.init();
  
  // Get saved language preference or default to Arabic (matching original behavior)
  final savedLanguage = CacheHelper.getCurrentLanguage();
  final startLocale = savedLanguage == 'en' 
      ? const Locale('en', 'UK') 
      : const Locale('ar', 'EG'); // Default to Arabic if not set
  
  await EasyLocalization.ensureInitialized();
  await DioHelper.init();
  await setupDependencyInjection();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await AppInitializer.init();

  runApp(
    EasyLocalization(
      saveLocale: true,
      useFallbackTranslations: true,
      fallbackLocale: const Locale('ar', 'EG'),
      startLocale: startLocale,
      supportedLocales: const [Locale('ar', 'EG'), Locale('en', 'UK')],
      path: 'assets/languages',
      child: Phoenix(
        child: NonStopApp(
          appRouter: AppRouter(),
          token: AppConstants.userToken,
        ),
      ),
    ),
  );
}
