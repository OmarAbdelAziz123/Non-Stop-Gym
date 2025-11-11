import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:non_stop/core/constants/app_styles.dart';
import 'package:non_stop/core/theme/theme.dart';
import 'package:non_stop/core/widgets/custom_app_bar.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {
        "title": "خصم جديد",
        "time": "1 د",
        "description":
            "لديك خصم بقيمة 10 ريال سعودي لديك خصم بقيمة 10 ريال سعودي لديك خصم بقيمة 10 ريال سعودي",
      },
      {
        "title": "طلبك قيد المراجعة",
        "time": "10 د",
        "description":
            "تم استلام طلبك بنجاح وجاري مراجعته من قبل الفريق المختص.",
      },
      {
        "title": "تمت الموافقة على طلبك",
        "time": "20 د",
        "description": "تمت الموافقة على طلبك ويمكنك المتابعة الآن.",
      },
      {
        "title": "خصم جديد",
        "time": "30 د",
        "description": "لديك خصم بقيمة 15 ريال سعودي صالح لمدة 24 ساعة فقط.",
      },
      {
        "title": "خصم جديد",
        "time": "30 د",
        "description": "لديك خصم بقيمة 15 ريال سعودي صالح لمدة 24 ساعة فقط.",
      },
    ];

    return 
    Container(
      decoration: const BoxDecoration(gradient: linearGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              const CustomAppBar(title: "الاشعارات"),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 20.h,
                  ),
                  child: ListView.builder(
                    itemCount: notifications.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = notifications[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 15.h),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xff02040B),
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              width: 0.5.w,
                              color: const Color(
                                0xff151515,
                              ).withValues(alpha: 0.41),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 22.h,
                              horizontal: 25.h,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      item["title"]!,
                                      style: Styles.contentBold.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      item["time"]!,
                                      style: Styles.contentBold.copyWith(
                                        color: const Color(0xff9F5A5B),
                                      ),
                                    ),
                                  ],
                                ),
                                11.verticalSpace,
                                Text(
                                  item["description"]!,
                                  style: Styles.footnoteBold.copyWith(
                                    height: 1.5.h,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
