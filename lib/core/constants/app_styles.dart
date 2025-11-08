import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:non_stop/core/constants/app_constants.dart';

abstract class Styles {
  static TextStyle getLocalizedTextStyle({
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.normal,
    Color color = Colors.black,
    double? letterSpacing,
  }) {
    // ✅ Safe fallback for early app startup
    final ctx = AppConstants.navigatorKey.currentContext;
    String locale = 'en';

    if (ctx != null) {
      locale = Localizations.localeOf(ctx).languageCode;
    }

    if (locale == 'ar') {
      return TextStyle(
        fontSize: fontSize.sp,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
        fontFamily: GoogleFonts.cairo().fontFamily,
      );
    } else {
      return TextStyle(
        fontSize: fontSize.sp,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
        fontFamily: GoogleFonts.cairo().fontFamily,
      );
    }
  }

  /// ==========================Display================================ ///
  /// ================================================================= ///
  static TextStyle display1 = getLocalizedTextStyle(
    fontSize: 44,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static TextStyle display2 = getLocalizedTextStyle(
    fontSize: 40,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static TextStyle display3 = getLocalizedTextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  /// ================================================================= ///

  /// ==========================HEADING================================ ///
  /// ================================================================= ///
  static TextStyle heading3 = getLocalizedTextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static TextStyle heading4 = getLocalizedTextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  /// ================================================================= ///

  /// ==========================EXTRA HEADINGS (for completeness)========================= ///
  static TextStyle heading1 = getLocalizedTextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static TextStyle heading2 = getLocalizedTextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  /// ==========================EXTRA BODY TEXT========================= ///
  static TextStyle contentSemibold = getLocalizedTextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );
  /// ================================================================= ///


  /// ==========================BODY TEXT=============================== ///
  /// ================================================================= ///
  static TextStyle featureBold = getLocalizedTextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static TextStyle featureSemibold = getLocalizedTextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );
  static TextStyle featureEmphasis = getLocalizedTextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );
  static TextStyle featureStandard = getLocalizedTextStyle(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );
  static TextStyle highlightBold = getLocalizedTextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static TextStyle highlightAccent = getLocalizedTextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );
  static TextStyle highlightEmphasis = getLocalizedTextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );
  static TextStyle highlightStandard = getLocalizedTextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );
  static TextStyle contentBold = getLocalizedTextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static TextStyle contentSemiBold = getLocalizedTextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );
  static TextStyle contentEmphasis = getLocalizedTextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );
  static TextStyle contentRegular = getLocalizedTextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );
  static TextStyle captionBold = getLocalizedTextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static TextStyle captionSemiBold = getLocalizedTextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );
  static TextStyle captionEmphasis = getLocalizedTextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );
  static TextStyle captionRegular = getLocalizedTextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );
  static TextStyle footnoteBold = getLocalizedTextStyle(
    fontSize: 10,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static TextStyle footnoteSemiboldBold = getLocalizedTextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );
  static TextStyle footnoteEmphasis = getLocalizedTextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );
  static TextStyle footnoteRegular = getLocalizedTextStyle(
    fontSize: 10,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );
}
