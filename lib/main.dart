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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await DioHelper.init();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await AppInitializer.init();

  await EasyLocalization.ensureInitialized();
  await CacheHelper.init();
  runApp(
    EasyLocalization(
      saveLocale: true,
      useFallbackTranslations: true,
      fallbackLocale: const Locale('ar', 'EG'),
      startLocale: const Locale('ar', 'EG'),
      supportedLocales: const [Locale('ar', 'EG'), Locale('en', 'UK')],
      path: 'assets/languages',
      child: Phoenix(
        child: MyApp(appRouter: AppRouter(), token: AppConstants.userToken),
      ),
    ),
  );
}
