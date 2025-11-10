// import 'package:flutter/material.dart';
// import 'package:non_stop/core/constants/app_colors.dart';
// import 'package:non_stop/core/constants/app_styles.dart';
//
// /// 🌙 Complete Dark Theme
// /// Mirrors the Light Theme with proper dark mode adjustments (M3 compliant)
// class DarkTheme {
//   static ThemeData get theme {
//     const borderRadius = 12.0;
//     const elevation = 2.0;
//
//     final base = ThemeData.dark(useMaterial3: true);
//
//     return base.copyWith(
//       brightness: Brightness.dark,
//
//       /// CORE COLORS
//       primaryColor: AppColors.primaryColor500,
//       scaffoldBackgroundColor: AppColors.neutralColor900,
//       splashColor: AppColors.primaryColor300.withValues(alpha:0.25),
//       highlightColor: AppColors.primaryColor300.withValues(alpha:0.15),
//       hintColor: AppColors.neutralColor400,
//       disabledColor: AppColors.neutralColor600,
//       shadowColor: Colors.black.withValues(alpha:0.4),
//       focusColor: AppColors.primaryColor400,
//       hoverColor: AppColors.primaryColor300,
//
//       /// COLOR SCHEME
//       colorScheme: base.colorScheme.copyWith(
//         brightness: Brightness.dark,
//         primary: AppColors.primaryColor400,
//         onPrimary: Colors.black,
//         primaryContainer: AppColors.primaryColor700,
//         secondary: AppColors.secondaryColor400,
//         onSecondary: Colors.black,
//         secondaryContainer: AppColors.secondaryColor700,
//         surface: AppColors.neutralColor900,
//         onSurface: AppColors.neutralColor100,
//         background: AppColors.neutralColor900,
//         onBackground: AppColors.neutralColor100,
//         error: AppColors.redColor200,
//         onError: Colors.black,
//         outline: AppColors.neutralColor600,
//         shadow: Colors.black54,
//         surfaceTint: AppColors.primaryColor400,
//         inverseSurface: AppColors.neutralColor100,
//         inversePrimary: AppColors.primaryColor200,
//       ),
//
//       /// TYPOGRAPHY
//       textTheme: TextTheme(
//         displayLarge: Styles.heroBold.copyWith(color: AppColors.neutralColor100),
//         displayMedium: Styles.heading1.copyWith(color: AppColors.neutralColor100),
//         displaySmall: Styles.heading2.copyWith(color: AppColors.neutralColor100),
//         headlineLarge: Styles.heading3.copyWith(color: AppColors.neutralColor100),
//         headlineMedium: Styles.heading4.copyWith(color: AppColors.neutralColor100),
//         headlineSmall: Styles.heading5.copyWith(color: AppColors.neutralColor100),
//         titleLarge: Styles.heading6.copyWith(color: AppColors.neutralColor100),
//         titleMedium: Styles.contentSemibold.copyWith(color: AppColors.neutralColor200),
//         titleSmall: Styles.contentRegular.copyWith(color: AppColors.neutralColor300),
//         bodyLarge: Styles.contentRegular.copyWith(color: AppColors.neutralColor200),
//         bodyMedium: Styles.captionRegular.copyWith(color: AppColors.neutralColor400),
//         bodySmall: Styles.footnoteRegular.copyWith(color: AppColors.neutralColor500),
//         labelLarge: Styles.captionAccent.copyWith(color: AppColors.primaryColor300),
//         labelMedium: Styles.footnoteSemiboldBold.copyWith(color: AppColors.primaryColor300),
//         labelSmall: Styles.footnoteRegular.copyWith(color: AppColors.primaryColor200),
//       ),
//
//       /// ICONS
//       iconTheme: IconThemeData(color: AppColors.primaryColor300, size: 24),
//       primaryIconTheme: IconThemeData(color: AppColors.neutralColor100, size: 24),
//
//       /// APP BAR
//       appBarTheme: AppBarTheme(
//         backgroundColor: AppColors.neutralColor800,
//         foregroundColor: AppColors.neutralColor100,
//         elevation: 0,
//         scrolledUnderElevation: 0,
//         centerTitle: true,
//         titleTextStyle: Styles.getLocalizedTextStyle(
//           fontSize: 18,
//           fontWeight: FontWeight.w600,
//           color: AppColors.neutralColor100,
//         ),
//         iconTheme: IconThemeData(color: AppColors.neutralColor100),
//       ),
//
//       /// BOTTOM APP BAR
//       bottomAppBarTheme: BottomAppBarThemeData(
//         color: AppColors.neutralColor800,
//         elevation: elevation,
//         surfaceTintColor: AppColors.primaryColor700,
//       ),
//
//       /// BUTTONS
//       elevatedButtonTheme: ElevatedButtonThemeData(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: AppColors.primaryColor400,
//           foregroundColor: Colors.black,
//           elevation: 0,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(borderRadius),
//           ),
//           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
//         ),
//       ),
//       outlinedButtonTheme: OutlinedButtonThemeData(
//         style: OutlinedButton.styleFrom(
//           side: BorderSide(color: AppColors.primaryColor300, width: 1.5),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(borderRadius),
//           ),
//           foregroundColor: AppColors.primaryColor300,
//         ),
//       ),
//       textButtonTheme: TextButtonThemeData(
//         style: TextButton.styleFrom(foregroundColor: AppColors.primaryColor300),
//       ),
//       iconButtonTheme: IconButtonThemeData(
//         style: IconButton.styleFrom(
//           foregroundColor: AppColors.primaryColor300,
//           highlightColor: AppColors.primaryColor200.withValues(alpha:0.2),
//         ),
//       ),
//
//       /// SWITCHES, RADIO, CHECKBOX
//       switchTheme: SwitchThemeData(
//         thumbColor: MaterialStateProperty.all(AppColors.primaryColor400),
//         trackColor: MaterialStateProperty.all(AppColors.primaryColor700.withValues(alpha:0.6)),
//       ),
//       checkboxTheme: CheckboxThemeData(
//         fillColor: MaterialStateProperty.resolveWith(
//               (states) => states.contains(MaterialState.selected)
//               ? AppColors.primaryColor400
//               : AppColors.neutralColor600,
//         ),
//       ),
//       radioTheme: RadioThemeData(
//         fillColor: MaterialStateProperty.resolveWith(
//               (states) => states.contains(MaterialState.selected)
//               ? AppColors.primaryColor400
//               : AppColors.neutralColor600,
//         ),
//       ),
//
//       /// INPUTS
//       inputDecorationTheme: InputDecorationTheme(
//         filled: true,
//         fillColor: AppColors.neutralColor800,
//         contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//         hintStyle: Styles.getLocalizedTextStyle(color: AppColors.neutralColor500),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(borderRadius),
//           borderSide: BorderSide(color: AppColors.neutralColor700),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(borderRadius),
//           borderSide: BorderSide(color: AppColors.primaryColor400, width: 2),
//         ),
//       ),
//
//       /// CARD
//       cardTheme: CardThemeData(
//         color: AppColors.neutralColor800,
//         elevation: elevation,
//         shadowColor: Colors.black45,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(borderRadius),
//         ),
//       ),
//
//       /// CHIP
//       chipTheme: ChipThemeData(
//         backgroundColor: AppColors.neutralColor700,
//         selectedColor: AppColors.primaryColor400,
//         labelStyle: Styles.captionRegular.copyWith(color: AppColors.neutralColor100),
//         secondaryLabelStyle: Styles.captionRegular.copyWith(color: Colors.black),
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//       ),
//
//       /// TOOLTIP
//       tooltipTheme: TooltipThemeData(
//         decoration: BoxDecoration(
//           color: AppColors.neutralColor700,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         textStyle: Styles.captionRegular.copyWith(color: AppColors.neutralColor100),
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
//         backgroundColor: AppColors.neutralColor800,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//         ),
//       ),
//
//       /// DRAWER
//       drawerTheme: DrawerThemeData(
//         backgroundColor: AppColors.neutralColor800,
//         elevation: elevation,
//         scrimColor: Colors.black.withValues(alpha:0.5),
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
//         backgroundColor: AppColors.neutralColor800,
//         elevation: elevation,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//         ),
//       ),
//
//       /// TAB BAR
//       tabBarTheme: TabBarThemeData(
//         labelColor: AppColors.primaryColor300,
//         unselectedLabelColor: AppColors.neutralColor500,
//         indicatorColor: AppColors.primaryColor300,
//         indicatorSize: TabBarIndicatorSize.label,
//         labelStyle: Styles.captionAccent.copyWith(color: AppColors.primaryColor300),
//         unselectedLabelStyle:
//         Styles.captionRegular.copyWith(color: AppColors.neutralColor600),
//       ),
//
//       /// PROGRESS INDICATOR
//       progressIndicatorTheme: ProgressIndicatorThemeData(
//         color: AppColors.primaryColor400,
//         circularTrackColor: AppColors.primaryColor700,
//       ),
//
//       /// NAVIGATION BAR
//       navigationBarTheme: NavigationBarThemeData(
//         backgroundColor: AppColors.neutralColor900,
//         indicatorColor: AppColors.primaryColor700.withValues(alpha:0.3),
//         labelTextStyle: MaterialStateProperty.all(
//           Styles.captionRegular.copyWith(color: AppColors.primaryColor300),
//         ),
//         iconTheme: MaterialStateProperty.all(
//           IconThemeData(color: AppColors.primaryColor300),
//         ),
//       ),
//
//       /// NAVIGATION RAIL
//       navigationRailTheme: NavigationRailThemeData(
//         backgroundColor: AppColors.neutralColor900,
//         selectedIconTheme: IconThemeData(color: AppColors.primaryColor300, size: 28),
//         unselectedIconTheme: IconThemeData(color: AppColors.neutralColor500, size: 24),
//         labelType: NavigationRailLabelType.all,
//         selectedLabelTextStyle:
//         Styles.captionAccent.copyWith(color: AppColors.primaryColor300),
//         unselectedLabelTextStyle:
//         Styles.captionRegular.copyWith(color: AppColors.neutralColor500),
//       ),
//
//       /// POPUP MENU
//       popupMenuTheme: PopupMenuThemeData(
//         color: AppColors.neutralColor800,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         textStyle: Styles.contentRegular.copyWith(color: AppColors.neutralColor100),
//       ),
//
//       /// DIVIDER
//       dividerTheme: DividerThemeData(
//         color: AppColors.neutralColor700,
//         thickness: 1,
//         space: 1,
//       ),
//
//       /// SCROLLBAR
//       scrollbarTheme: ScrollbarThemeData(
//         thumbColor: MaterialStateProperty.all(AppColors.primaryColor700),
//         radius: const Radius.circular(8),
//         thickness: MaterialStateProperty.all(6),
//       ),
//
//       /// SLIDER
//       sliderTheme: SliderThemeData(
//         activeTrackColor: AppColors.primaryColor400,
//         inactiveTrackColor: AppColors.primaryColor700,
//         thumbColor: AppColors.primaryColor400,
//         overlayColor: AppColors.primaryColor200.withValues(alpha:0.3),
//       ),
//
//       /// BOTTOM NAVIGATION BAR (legacy)
//       bottomNavigationBarTheme: BottomNavigationBarThemeData(
//         backgroundColor: AppColors.neutralColor900,
//         selectedItemColor: AppColors.primaryColor300,
//         unselectedItemColor: AppColors.neutralColor500,
//         elevation: elevation,
//         showUnselectedLabels: true,
//         type: BottomNavigationBarType.fixed,
//       ),
//
//       /// FLOATING ACTION BUTTON
//       floatingActionButtonTheme: FloatingActionButtonThemeData(
//         backgroundColor: AppColors.primaryColor400,
//         foregroundColor: Colors.black,
//         elevation: elevation,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(14),
//         ),
//       ),
//     );
//   }
// }
