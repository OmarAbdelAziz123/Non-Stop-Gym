import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:non_stop/core/constants/app_colors.dart';
import 'package:non_stop/core/constants/app_styles.dart';
import 'package:non_stop/core/theme/theme.dart';
import 'package:non_stop/core/widgets/custom_app_bar.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  int? expandedIndex;

  final List<Map<String, String>> faqItems = [
    {
      'question': 'هل يوجد مواعيد مخصصة للرجال والنساء؟',
      'answer':
          'نعم تم تخصيص أوقات ومرافق منفصلة لكل من الرجال والنساء لضمان الخصوصية الكاملة.',
    },
    {'question': 'من يمكنه الإشتراك في النادي؟', 'answer': 'ذكر او انثي '},
    {
      'question': 'ما الخدمات المتوفرة في النادي؟',
      'answer':
          'يوفر النادي صالة رياضية مجهزة بالكامل، أحواض سباحة، ملاعب، وبرامج تدريب متنوعة.',
    },
    {
      'question': 'هل يمكن الحصول على جلسة تدريب خاصة؟',
      'answer':
          'نعم، يمكنك حجز جلسات تدريب خاصة مع مدربين محترفين حسب جدولك الزمني.',
    },
    {
      'question': 'هل يوجد مكان للتبديل الملابس والاستحمام؟',
      'answer':
          'نعم، يوفر النادي غرف تبديل ملابس حديثة ومرافق استحمام نظيفة ومجهزة.',
    },
    {
      'question': 'هل يمكن الدخول في أي وقت؟',
      'answer':
          'النادي مفتوح من الساعة 6 صباحاً حتى 6 مساءً جميع أيام الأسبوع.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: linearGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              CustomAppBar(title: 'faqs'.tr()),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 20.h,
                  ),
                  itemCount: faqItems.length,
                  itemBuilder: (context, index) {
                    final isExpanded = expandedIndex == index;
                    final item = faqItems[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xff151515).withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: const Color(
                              0xff151515,
                            ).withValues(alpha: 0.41),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  expandedIndex = isExpanded ? null : index;
                                });
                              },
                              borderRadius: BorderRadius.circular(12.r),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 16.h,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        item['question']!,
                                        style: Styles.captionBold.copyWith(
                                          color: AppColors.neutralColor100,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                    12.horizontalSpace,
                                    Icon(
                                      isExpanded
                                          ? Icons.keyboard_arrow_up
                                          : Icons.keyboard_arrow_down,
                                      color: const Color(0xff9F5A5B),
                                      size: 24.sp,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (isExpanded)
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.only(
                                  left: 16.w,
                                  right: 16.w,
                                  top: 8.h,
                                  bottom: 16.h,
                                ),
                                child: Text(
                                  item['answer']!,
                                  style: Styles.captionBold.copyWith(
                                    color: AppColors.neutralColor300,
                                    height: 1.5,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
