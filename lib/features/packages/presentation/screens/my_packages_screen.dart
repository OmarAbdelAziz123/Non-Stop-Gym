import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:non_stop/common/extensions/build_context_extensions.dart';
import 'package:non_stop/core/constants/app_colors.dart';
import 'package:non_stop/core/constants/app_styles.dart';
import 'package:non_stop/core/constants/hex_colors.dart';
import 'package:non_stop/core/widgets/button/custom_button_widget.dart';
import 'package:non_stop/core/widgets/row/custom_row_with_check_widget.dart';
import 'package:non_stop/features/main%20layout/business_logic/main_layout_cubit.dart';
import 'package:non_stop/features/packages/presentation/screens/packages_screen.dart';

class MyPackagesScreen extends StatefulWidget {
  const MyPackagesScreen({super.key});

  @override
  State<MyPackagesScreen> createState() => _MyPackagesScreenState();
}

class _MyPackagesScreenState extends State<MyPackagesScreen> {
  bool isActive = true; // true = جارية, false = منتهية

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xff160618),
            const Color(0xff160618),
            const Color(0xff160618).withAlpha(20),
            const Color(0xff160618).withAlpha(20),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
            child: Column(
              children: [
                /// ===== Header =====
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        context.pop();
                      },
                      child: Container(
                        width: 44.w,
                        height: 44.h,
                        decoration: BoxDecoration(
                          color: const Color(0xff2A1A2C),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: SvgPicture.asset(
                          "assets/svgs/Back _con.svg",
                          width: 24.w,
                          height: 24.h,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                    Text(
                      'باقاتي',
                      style: Styles.heading2.copyWith(color: Colors.white),
                    ),
                    Container(
                      width: 44.w,
                      height: 44.h,
                      decoration: BoxDecoration(
                        color: const Color(0xff2A1A2C),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: SvgPicture.asset(
                        "assets/svgs/Notification.svg",
                        width: 24.w,
                        height: 24.h,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ],
                ),

                /// ===== Body =====
                Expanded(
                  child: Column(
                    children: [
                      42.verticalSpace,

                      /// ===== Toggle Buttons =====
                      Row(
                        spacing: 8.w,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // ---- جارية ----
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() => isActive = true);
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                padding: EdgeInsets.symmetric(vertical: 13.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: isActive
                                      ? hexToColor('#9F5A5B')
                                      : hexToColor('#02040B'),
                                  border: Border.all(
                                    color: isActive
                                        ? hexToColor('#B98B8C')
                                        : Colors.transparent,
                                    width: 1.w,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'جارية',
                                    style: Styles.featureEmphasis.copyWith(
                                      color: isActive
                                          ? AppColors.neutralColor100
                                          : AppColors.neutralColor500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // ---- منتهية ----
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() => isActive = false);
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                padding: EdgeInsets.symmetric(vertical: 13.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: !isActive
                                      ? hexToColor('#9F5A5B')
                                      : hexToColor('#02040B'),
                                  border: Border.all(
                                    color: !isActive
                                        ? hexToColor('#B98B8C')
                                        : Colors.transparent,
                                    width: 1.w,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'منتهية',
                                    style: Styles.featureEmphasis.copyWith(
                                      color: !isActive
                                          ? AppColors.neutralColor100
                                          : AppColors.neutralColor500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      /// Example: يمكن هنا بعدين تضيف محتوى الباقات بناءً على الحالة
                      34.verticalSpace,
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: isActive
                            ? CustomActiveBodyWidget()
                            : CustomInactiveBodyWidget(),
                      ),
                    ],
                  ),
                ),

                if (isActive)
                  CustomButtonWidget(
                    color: hexToColor('#9F5A5B'),
                    text: 'اشتراك في باقة جديدة',
                    textStyle: Styles.highlightBold.copyWith(
                      color: AppColors.neutralColor100,
                    ),
                    onPressed: () {
                      context.push(
                        MaterialPageRoute(
                          builder: (context) => const PackagesScreen(),
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomActiveBodyWidget extends StatelessWidget {
  const CustomActiveBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey(1),
      children: [
        Container(
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
            top: 36.h,
            bottom: 24.h,
          ),
          decoration: BoxDecoration(
            color: hexToColor('#02040B'),
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: Color(0xff15151569).withValues(alpha: .5),
              width: .5.w,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(8.sp),
                    decoration: BoxDecoration(
                      color: Color(0xff9f5a5b1a).withAlpha(10),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Image.asset(
                      'assets/pngs/diamond.png',
                      width: 26.w,
                      height: 26.h,
                    ),
                  ),

                  Row(
                    children: [
                      Text(
                        '120',
                        style: Styles.display3.copyWith(
                          color: AppColors.neutralColor100,
                        ),
                      ),
                      SvgPicture.asset(
                        'assets/svgs/ryal.svg',
                        fit: BoxFit.scaleDown,
                      ),
                    ],
                  ),
                ],
              ),
              8.verticalSpace,
              Text(
                'الباقة الذهبية ',
                style: Styles.featureSemibold.copyWith(
                  color: AppColors.neutralColor100,
                ),
              ),
              16.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(5.r),
                        border: Border.all(
                          color: Color(0xFF9F5A5B).withValues(alpha: .5),
                          width: .5.w,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '6 شهور',
                          style: Styles.featureSemibold.copyWith(
                            color: hexToColor('#9F5A5B'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              19.verticalSpace,
              Text(
                'المميزات',
                style: Styles.featureSemibold.copyWith(
                  color: AppColors.neutralColor100,
                ),
              ),
              21.verticalSpace,
              CustomRowWithCheckWidget(
                text: 'دخول كامل للجيم واستخدام جميع الأجهزة',
              ),
              6.verticalSpace,

              CustomRowWithCheckWidget(text: '2 حصة بيلاتس أسبوعيًا'),
              6.verticalSpace,

              CustomRowWithCheckWidget(text: 'خصم 20% على جلسات كراسي المساج'),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomInactiveBodyWidget extends StatelessWidget {
  const CustomInactiveBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey(2),
      children: [
        Container(
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
            top: 36.h,
            bottom: 24.h,
          ),
          decoration: BoxDecoration(
            color: hexToColor('#02040B'),
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: Color(0xff15151569).withValues(alpha: .5),
              width: .5.w,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(8.sp),
                    decoration: BoxDecoration(
                      color: Color(0xff9f5a5b1a).withAlpha(10),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Image.asset(
                      'assets/pngs/diamond2.png',
                      width: 26.w,
                      height: 26.h,
                    ),
                  ),

                  Row(
                    children: [
                      Text(
                        '80',
                        style: Styles.display3.copyWith(
                          color: AppColors.neutralColor100,
                        ),
                      ),
                      SvgPicture.asset(
                        'assets/svgs/ryal.svg',
                        fit: BoxFit.scaleDown,
                      ),
                    ],
                  ),
                ],
              ),
              8.verticalSpace,
              Text(
                'الباقة البرونزية ',
                style: Styles.featureSemibold.copyWith(
                  color: AppColors.neutralColor100,
                ),
              ),
              16.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(5.r),
                        border: Border.all(
                          color: Color(0xFF9F5A5B).withValues(alpha: .5),
                          width: .5.w,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '3 شهور',
                          style: Styles.featureSemibold.copyWith(
                            color: hexToColor('#9F5A5B'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              19.verticalSpace,
              Text(
                'المميزات',
                style: Styles.featureSemibold.copyWith(
                  color: AppColors.neutralColor100,
                ),
              ),
              21.verticalSpace,
              CustomRowWithCheckWidget(
                text: 'دخول للجيم واستخدام الأجهزة الأساسية',
              ),
              6.verticalSpace,

              CustomRowWithCheckWidget(text: 'حصص جماعية محدودة'),
            ],
          ),
        ),
      ],
    );
  }
}
