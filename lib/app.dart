// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:non_stop/core/constants/app_constants.dart';
// import 'package:non_stop/core/routing/app_router.dart';
// import 'package:non_stop/core/routing/routes_name.dart';

// /// 🧩 Root widget of the Tenth Tune app.
// /// - Ultra-light build method (no FutureBuilder)
// /// - Uses pre-initialized ThemeCubit (for zero jank)
// /// - Fully responsive and modular
// class MyApp extends StatelessWidget {
//   const MyApp({super.key, required this.appRouter, String? token});
//   final AppRouter appRouter;

//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: const Size(390, 844),
//       minTextAdapt: true,
//       splitScreenMode: true,
//       builder: (_, __) => MaterialApp(
//         title: AppConstants.appName,
//         debugShowCheckedModeBanner: false,
//         navigatorKey: AppConstants.navigatorKey,
//         localizationsDelegates: context.localizationDelegates,

//         /// 🌐 Set default locale to Arabic
//         locale: context.locale,

//         /// 🌐 Set supported locales
//         supportedLocales: context.supportedLocales,

//         builder: EasyLoading.init(),

//         /// 🧭 Centralized routing
//         onGenerateRoute: appRouter.generateRoute,
//         initialRoute: Routes.mainlayoutScreen,
//       ),
//     );
//   }
// }
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:non_stop/core/constants/app_constants.dart';
import 'package:non_stop/core/routing/app_router.dart';
import 'package:non_stop/core/routing/routes_name.dart';

class NonStopApp extends StatelessWidget {
  const NonStopApp({super.key, required this.appRouter, String? token});

  final AppRouter appRouter;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      child: MaterialApp(
        navigatorKey: AppConstants.navigatorKey,

        debugShowCheckedModeBanner: false,
        title: "Non Stop ",
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.transparent,
          primaryColor: const Color(0xff9F5A5B),
          fontFamily: 'Arial',
        ),
        onGenerateRoute: appRouter.generateRoute,
        initialRoute: Routes.splashScreen,
        builder: EasyLoading.init(),
      ),
    );
  }
}
