import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:non_stop/core/constants/app_constants.dart';

abstract class Styles {
  static TextStyle getLocalizedTextStyle({
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.normal,
    Color color = Colors.white,
    double? letterSpacing,
  }) {
    String locale =
        AppConstants.navigatorKey.currentContext!.locale.languageCode;

    // Use GoogleFonts.cairo() for both Arabic and English
    return TextStyle(
      fontFamily: GoogleFonts.cairo().fontFamily,
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
    );
  }

  /// ==========================HEADING================================ ///
  static TextStyle display1 = getLocalizedTextStyle(
    fontSize: 44,
    fontWeight: FontWeight.bold,
  );
  static TextStyle display2 = getLocalizedTextStyle(
    fontSize: 40,
    fontWeight: FontWeight.bold,
  );
  static TextStyle display3 = getLocalizedTextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
  );
  static TextStyle heading1 = getLocalizedTextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
  );
  static TextStyle heading2 = getLocalizedTextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  static TextStyle heading3 = getLocalizedTextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );
  static TextStyle heading4 = getLocalizedTextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  /// ==========================BODY TEXT=============================== ///
  static TextStyle featureBold = getLocalizedTextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  static TextStyle featureSemiBold = getLocalizedTextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  static TextStyle featureEmphasis = getLocalizedTextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );
  static TextStyle featureStandard = getLocalizedTextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );
  static TextStyle highlightBold = getLocalizedTextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  static TextStyle highlightSemiBold = getLocalizedTextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
  static TextStyle highlightEmphasis = getLocalizedTextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  static TextStyle highlightStandard = getLocalizedTextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );
  static TextStyle contentBold = getLocalizedTextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );
  static TextStyle contentSemiBold = getLocalizedTextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );
  static TextStyle contentEmphasis = getLocalizedTextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  static TextStyle contentRegular = getLocalizedTextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
  static TextStyle captionBold = getLocalizedTextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
  );
  static TextStyle captionSemiBold = getLocalizedTextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );
  static TextStyle captionEmphasis = getLocalizedTextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );
  static TextStyle captionRegular = getLocalizedTextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
  static TextStyle footnoteBold = getLocalizedTextStyle(
    fontSize: 10,
    fontWeight: FontWeight.bold,
  );
  static TextStyle footnoteSemiBold = getLocalizedTextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w600,
  );
  static TextStyle footnoteEmphasis = getLocalizedTextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
  );
  static TextStyle footnoteRegular = getLocalizedTextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w400,
  );
}
