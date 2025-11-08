// import 'package:flutter/material.dart';
// import 'package:non_stop/core/constants/app_colors.dart';
// import 'package:non_stop/core/constants/app_styles.dart';
//
// /// 🌞 Complete Light Theme
// /// Covers all Material 3 ThemeData attributes for professional use.
// class LightTheme {
//   static ThemeData get theme {
//     const borderRadius = 12.0;
//     const elevation = 2.0;
//
//     final base = ThemeData.light(useMaterial3: true);
//
//     return base.copyWith(
//       brightness: Brightness.light,
//
//       /// CORE COLORS
//       primaryColor: AppColors.primaryColor500,
//       scaffoldBackgroundColor: AppColors.neutralColor100,
//       splashColor: AppColors.primaryColor100.withOpacity(0.2),
//       highlightColor: AppColors.primaryColor100.withOpacity(0.1),
//       hintColor: AppColors.neutralColor500,
//       disabledColor: AppColors.neutralColor400,
//       shadowColor: AppColors.neutralColor200,
//       focusColor: AppColors.primaryColor200,
//       hoverColor: AppColors.primaryColor100,
//
//       /// COLOR SCHEME (M3)
//       colorScheme: base.colorScheme.copyWith(
//         primary: AppColors.primaryColor500,
//         onPrimary: Colors.white,
//         primaryContainer: AppColors.primaryColor100,
//         secondary: AppColors.secondaryColor500,
//         onSecondary: Colors.white,
//         secondaryContainer: AppColors.secondaryColor100,
//         surface: AppColors.neutralColor100,
//         onSurface: AppColors.neutralColor900,
//         background: AppColors.neutralColor100,
//         onBackground: AppColors.neutralColor900,
//         error: AppColors.redColor100,
//         onError: Colors.white,
//         outline: AppColors.neutralColor400,
//         shadow: AppColors.neutralColor200,
//         surfaceTint: AppColors.primaryColor100,
//         inverseSurface: AppColors.neutralColor900,
//         inversePrimary: AppColors.primaryColor700,
//       ),
//
//       /// TYPOGRAPHY
//       textTheme: TextTheme(
//         displayLarge: Styles.heroBold.copyWith(color: AppColors.neutralColor900),
//         displayMedium: Styles.heading1.copyWith(color: AppColors.neutralColor900),
//         displaySmall: Styles.heading2.copyWith(color: AppColors.neutralColor900),
//         headlineLarge: Styles.heading3.copyWith(color: AppColors.neutralColor900),
//         headlineMedium: Styles.heading4.copyWith(color: AppColors.neutralColor900),
//         headlineSmall: Styles.heading5.copyWith(color: AppColors.neutralColor900),
//         titleLarge: Styles.heading6.copyWith(color: AppColors.neutralColor900),
//         titleMedium: Styles.contentSemibold.copyWith(color: AppColors.neutralColor800),
//         titleSmall: Styles.contentRegular.copyWith(color: AppColors.neutralColor700),
//         bodyLarge: Styles.contentRegular.copyWith(color: AppColors.neutralColor800),
//         bodyMedium: Styles.captionRegular.copyWith(color: AppColors.neutralColor700),
//         bodySmall: Styles.footnoteRegular.copyWith(color: AppColors.neutralColor600),
//         labelLarge: Styles.captionAccent.copyWith(color: AppColors.primaryColor500),
//         labelMedium: Styles.footnoteSemiboldBold.copyWith(color: AppColors.primaryColor500),
//         labelSmall: Styles.footnoteRegular.copyWith(color: AppColors.primaryColor400),
//       ),
//
//       /// ICONS
//       iconTheme: IconThemeData(
//         color: AppColors.primaryColor500,
//         size: 24,
//       ),
//
//       primaryIconTheme: IconThemeData(
//         color: AppColors.neutralColor900,
//         size: 24,
//       ),
//
//       /// APP BAR
//       appBarTheme: AppBarTheme(
//         backgroundColor: AppColors.primaryColor500,
//         foregroundColor: Colors.white,
//         elevation: 1,
//         scrolledUnderElevation: 0,
//         centerTitle: true,
//         titleTextStyle: Styles.getLocalizedTextStyle(
//           fontSize: 18,
//           fontWeight: FontWeight.w600,
//           color: Colors.white,
//         ),
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//
//       /// BOTTOM APP BAR
//       bottomAppBarTheme: BottomAppBarThemeData(
//         color: Colors.white,
//         elevation: elevation,
//         surfaceTintColor: AppColors.primaryColor100,
//       ),
//
//       /// BUTTONS
//       elevatedButtonTheme: ElevatedButtonThemeData(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: AppColors.primaryColor500,
//           foregroundColor: Colors.white,
//           elevation: 0,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(borderRadius),
//           ),
//           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
//         ),
//       ),
//       outlinedButtonTheme: OutlinedButtonThemeData(
//         style: OutlinedButton.styleFrom(
//           side: BorderSide(color: AppColors.primaryColor500, width: 1.5),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(borderRadius),
//           ),
//           foregroundColor: AppColors.primaryColor500,
//         ),
//       ),
//       textButtonTheme: TextButtonThemeData(
//         style: TextButton.styleFrom(
//           foregroundColor: AppColors.primaryColor500,
//         ),
//       ),
//       iconButtonTheme: IconButtonThemeData(
//         style: IconButton.styleFrom(
//           foregroundColor: AppColors.primaryColor500,
//           highlightColor: AppColors.primaryColor100,
//         ),
//       ),
//
//       /// SWITCHES, RADIO, CHECKBOX
//       switchTheme: SwitchThemeData(
//         thumbColor: MaterialStateProperty.all(AppColors.primaryColor500),
//         trackColor:
//         MaterialStateProperty.all(AppColors.primaryColor200.withOpacity(0.5)),
//       ),
//       checkboxTheme: CheckboxThemeData(
//         fillColor: MaterialStateProperty.resolveWith(
//               (states) =>
//           states.contains(MaterialState.selected)
//               ? AppColors.primaryColor500
//               : AppColors.neutralColor400,
//         ),
//       ),
//       radioTheme: RadioThemeData(
//         fillColor: MaterialStateProperty.resolveWith(
//               (states) =>
//           states.contains(MaterialState.selected)
//               ? AppColors.primaryColor500
//               : AppColors.neutralColor400,
//         ),
//       ),
//
//       /// TEXT FIELDS
//       inputDecorationTheme: InputDecorationTheme(
//         filled: true,
//         fillColor: Colors.white,
//         contentPadding:
//         const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//         hintStyle: Styles.getLocalizedTextStyle(color: AppColors.neutralColor500),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(borderRadius),
//           borderSide: BorderSide(color: AppColors.neutralColor300),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(borderRadius),
//           borderSide: BorderSide(color: AppColors.primaryColor500, width: 2),
//         ),
//       ),
//
//       /// CARD
//       cardTheme: CardThemeData(
//         color: Colors.white,
//         elevation: elevation,
//         shadowColor: AppColors.neutralColor200,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(borderRadius),
//         ),
//       ),
//
//       /// CHIP
//       chipTheme: ChipThemeData(
//         backgroundColor: AppColors.neutralColor200,
//         selectedColor: AppColors.primaryColor500,
//         labelStyle: Styles.captionRegular.copyWith(color: AppColors.neutralColor900),
//         secondaryLabelStyle: Styles.captionRegular.copyWith(color: Colors.white),
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//       ),
//
//       /// TOOLTIP
//       tooltipTheme: TooltipThemeData(
//         decoration: BoxDecoration(
//           color: AppColors.neutralColor800,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         textStyle: Styles.captionRegular.copyWith(color: Colors.white),
//       ),
//
//       /// SNACKBAR
//       snackBarTheme: SnackBarThemeData(
//         backgroundColor: AppColors.neutralColor800,
//         contentTextStyle: Styles.captionRegular.copyWith(color: Colors.white),
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(borderRadius),
//         ),
//       ),
//
//       /// DIALOG
//       dialogTheme: DialogThemeData(
//         backgroundColor: Colors.white,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//         ),
//       ),
//
//       /// DRAWER
//       drawerTheme: DrawerThemeData(
//         backgroundColor: Colors.white,
//         elevation: elevation,
//         scrimColor: Colors.black.withOpacity(0.4),
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//             topRight: Radius.circular(16),
//             bottomRight: Radius.circular(16),
//           ),
//         ),
//       ),
//
//       /// BOTTOM SHEET
//       bottomSheetTheme: BottomSheetThemeData(
//         backgroundColor: Colors.white,
//         elevation: elevation,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//         ),
//       ),
//
//       /// TAB BAR
//       tabBarTheme: TabBarThemeData(
//         labelColor: AppColors.primaryColor500,
//         unselectedLabelColor: AppColors.neutralColor500,
//         indicatorColor: AppColors.primaryColor500,
//         indicatorSize: TabBarIndicatorSize.label,
//         labelStyle: Styles.captionAccent.copyWith(color: AppColors.primaryColor500),
//         unselectedLabelStyle:
//         Styles.captionRegular.copyWith(color: AppColors.neutralColor600),
//       ),
//
//       /// PROGRESS INDICATOR
//       progressIndicatorTheme: ProgressIndicatorThemeData(
//         color: AppColors.primaryColor500,
//         circularTrackColor: AppColors.primaryColor100,
//       ),
//
//       /// NAVIGATION BAR
//       navigationBarTheme: NavigationBarThemeData(
//         backgroundColor: Colors.white,
//         indicatorColor: AppColors.primaryColor100.withOpacity(0.3),
//         labelTextStyle: MaterialStateProperty.all(
//           Styles.captionRegular.copyWith(color: AppColors.primaryColor500),
//         ),
//         iconTheme: MaterialStateProperty.all(
//           IconThemeData(color: AppColors.primaryColor500),
//         ),
//       ),
//
//       /// NAVIGATION RAIL
//       navigationRailTheme: NavigationRailThemeData(
//         backgroundColor: Colors.white,
//         selectedIconTheme:
//         IconThemeData(color: AppColors.primaryColor500, size: 28),
//         unselectedIconTheme:
//         IconThemeData(color: AppColors.neutralColor500, size: 24),
//         labelType: NavigationRailLabelType.all,
//         selectedLabelTextStyle:
//         Styles.captionAccent.copyWith(color: AppColors.primaryColor500),
//         unselectedLabelTextStyle:
//         Styles.captionRegular.copyWith(color: AppColors.neutralColor500),
//       ),
//
//       /// POPUP MENU
//       popupMenuTheme: PopupMenuThemeData(
//         color: Colors.white,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         textStyle: Styles.contentRegular.copyWith(color: AppColors.neutralColor900),
//       ),
//
//       /// DIVIDER
//       dividerTheme: DividerThemeData(
//         color: AppColors.neutralColor200,
//         thickness: 1,
//         space: 1,
//       ),
//
//       /// SCROLLBAR
//       scrollbarTheme: ScrollbarThemeData(
//         thumbColor: MaterialStateProperty.all(AppColors.primaryColor200),
//         radius: const Radius.circular(8),
//         thickness: MaterialStateProperty.all(6),
//       ),
//
//       /// SLIDER
//       sliderTheme: SliderThemeData(
//         activeTrackColor: AppColors.primaryColor500,
//         inactiveTrackColor: AppColors.primaryColor200,
//         thumbColor: AppColors.primaryColor500,
//         overlayColor: AppColors.primaryColor100.withOpacity(0.3),
//       ),
//
//       /// BOTTOM NAVIGATION BAR (legacy)
//       bottomNavigationBarTheme: BottomNavigationBarThemeData(
//         backgroundColor: Colors.white,
//         selectedItemColor: AppColors.primaryColor500,
//         unselectedItemColor: AppColors.neutralColor500,
//         elevation: elevation,
//         showUnselectedLabels: true,
//         type: BottomNavigationBarType.fixed,
//       ),
//
//       /// FLOATING ACTION BUTTON
//       floatingActionButtonTheme: FloatingActionButtonThemeData(
//         backgroundColor: AppColors.primaryColor500,
//         foregroundColor: Colors.white,
//         elevation: elevation,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(14),
//         ),
//       ),
//     );
//   }
// }
