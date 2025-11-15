import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:non_stop/core/cache_helper/cache_helper.dart';
import 'package:non_stop/core/constants/app_colors.dart';
import 'package:non_stop/core/constants/app_styles.dart';

class LanguageSelectionBottomSheet extends StatelessWidget {
  const LanguageSelectionBottomSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const LanguageSelectionBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.locale;
    final isArabic = currentLocale.languageCode == 'ar';

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff02040B),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[700],
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              24.verticalSpace,

              // Title
              Text(
                'appLanguage'.tr(),
                style: Styles.heading2.copyWith(
                  color: AppColors.neutralColor100,
                  fontFamily: GoogleFonts.cairo().fontFamily,
                ),
              ),
              24.verticalSpace,

              // Language options
              _LanguageOption(
                title: 'arabic'.tr(),
                isSelected: isArabic,
                onTap: () async {
                  if (!isArabic) {
                    await CacheHelper.changeLanguageToAr();
                    await context.setLocale(const Locale('ar', 'EG'));
                    if (context.mounted) {
                      Navigator.of(context).pop();
                      Phoenix.rebirth(context);
                    }
                  } else {
                    Navigator.of(context).pop();
                  }
                },
              ),
              16.verticalSpace,
              _LanguageOption(
                title: 'english'.tr(),
                isSelected: !isArabic,
                onTap: () async {
                  if (isArabic) {
                    await CacheHelper.changeLanguageToEn();
                    await context.setLocale(const Locale('en', 'UK'));
                    if (context.mounted) {
                      Navigator.of(context).pop();
                      Phoenix.rebirth(context);
                    }
                  } else {
                    Navigator.of(context).pop();
                  }
                },
              ),

              24.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Determine subtitle: show opposite language name
    final subtitleText = title == 'arabic'.tr() 
        ? 'english'.tr()  // If Arabic is selected, show English as subtitle
        : 'arabic'.tr();  // If English is selected, show Arabic as subtitle
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF9F5A5B).withOpacity(0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF9F5A5B)
                : Colors.grey.withOpacity(0.3),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Styles.featureSemibold.copyWith(
                      color: AppColors.neutralColor100,
                      fontFamily: GoogleFonts.cairo().fontFamily,
                    ),
                  ),
                  4.verticalSpace,
                  Text(
                    subtitleText,
                    style: Styles.contentRegular.copyWith(
                      color: AppColors.neutralColor500,
                      fontFamily: GoogleFonts.cairo().fontFamily,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: const Color(0xFF9F5A5B),
                size: 24.sp,
              )
            else
              Icon(
                Icons.circle_outlined,
                color: Colors.grey[600],
                size: 24.sp,
              ),
          ],
        ),
      ),
    );
  }
}

