import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:non_stop/core/constants/app_constants.dart';
import 'package:non_stop/router/app_router.dart';
import 'package:non_stop/router/route_name.dart';

/// 🧩 Root widget of the Tenth Tune app.
/// - Ultra-light build method (no FutureBuilder)
/// - Uses pre-initialized ThemeCubit (for zero jank)
/// - Fully responsive and modular
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) => MaterialApp(
        title: AppConstants.appName,
        debugShowCheckedModeBanner: false,
        navigatorKey: AppConstants.navigatorKey,
        localizationsDelegates: context.localizationDelegates,
        /// 🌐 Set default locale to Arabic
        locale: context.locale,
        /// 🌐 Set supported locales
        supportedLocales: context.supportedLocales,

        builder: EasyLoading.init(),

        /// 🧭 Centralized routing
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: RouteNames.splash,
      ),
    );
  }
}
