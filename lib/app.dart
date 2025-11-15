import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
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
          fontFamily: GoogleFonts.cairo().fontFamily,
          textTheme: TextTheme(
            displayLarge: TextStyle(fontFamily: GoogleFonts.cairo().fontFamily),
            displayMedium: TextStyle(fontFamily: GoogleFonts.cairo().fontFamily),
            displaySmall: TextStyle(fontFamily: GoogleFonts.cairo().fontFamily),
            headlineLarge: TextStyle(fontFamily: GoogleFonts.cairo().fontFamily),
            headlineMedium: TextStyle(fontFamily: GoogleFonts.cairo().fontFamily),
            headlineSmall: TextStyle(fontFamily: GoogleFonts.cairo().fontFamily),
            titleLarge: TextStyle(fontFamily: GoogleFonts.cairo().fontFamily),
            titleMedium: TextStyle(fontFamily: GoogleFonts.cairo().fontFamily),
            titleSmall: TextStyle(fontFamily: GoogleFonts.cairo().fontFamily),
            bodyLarge: TextStyle(fontFamily: GoogleFonts.cairo().fontFamily),
            bodyMedium: TextStyle(fontFamily: GoogleFonts.cairo().fontFamily),
            bodySmall: TextStyle(fontFamily: GoogleFonts.cairo().fontFamily),
            labelLarge: TextStyle(fontFamily: GoogleFonts.cairo().fontFamily),
            labelMedium: TextStyle(fontFamily: GoogleFonts.cairo().fontFamily),
            labelSmall: TextStyle(fontFamily: GoogleFonts.cairo().fontFamily),
          ),
        ),
        onGenerateRoute: appRouter.generateRoute,
        initialRoute: Routes.splashScreen,
        builder: EasyLoading.init(),
      ),
    );
  }
}
