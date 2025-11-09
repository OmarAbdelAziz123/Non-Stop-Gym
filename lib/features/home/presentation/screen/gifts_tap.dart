import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:non_stop/core/constants/app_styles.dart';
import 'package:non_stop/core/theme/app_colors.dart';
import 'package:non_stop/core/widgets/button/custom_button_widget.dart';

class GiftsTap extends StatelessWidget {
  const GiftsTap({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
          child: Text(
            style: TextStyle(
              color: AppColors.neutralColor100,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            'bestOffers'.tr(),
          ),
        ),
        10.verticalSpace,
        SizedBox(
          height: 180.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: Container(
                  padding: EdgeInsets.all(12.sp),
                  width: 270.w,
                  decoration: BoxDecoration(
                    color: Color(0xFF02040B),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.r),
                              border: Border.all(
                                color: const Color(
                                  0xff151515,
                                ).withValues(alpha: 0.41),
                                width: 1.w, //
                              ),
                              color: Color(0xff9F5A5B).withValues(alpha: 0.10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: Image.asset(
                                "assets/pngs/offer.png",
                                height: 30.h,
                                width: 30.w,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.r),
                              border: Border.all(
                                color: const Color(0xff9F5A5B),
                                width: 0.5.w, //
                              ),
                              color: Color(0xff9F5A5B),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 4.w,
                                vertical: 2.h,
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/svgs/100.svg',
                                    width: 12.w,
                                    height: 14.h,
                                  ),
                                  4.horizontalSpace,
                                  Text(
                                    "30%",
                                    style: Styles.captionSemiBold.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      10.verticalSpace,
                      Text(
                        'الباقة البرونزية'.tr(),
                        style: Styles.contentRegular.copyWith(
                          color: Colors.white,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '3 شهور',
                        style: Styles.contentRegular.copyWith(
                          color: Colors.white,
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '150 ريال',
                            style: Styles.contentRegular.copyWith(
                              color: Colors.white,
                              fontSize: 16.sp,
                            ),
                          ),
                          CustomButtonWidget(
                            text: 'اشترك الان'.tr(),
                            textStyle: Styles.captionBold.copyWith(
                              color: Colors.white,
                            ),
                            borderRadius: 3.r,
                            width: 100.w,
                            height: 30.h,
                            color: Color(0xff4A7DFF),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 24.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'تواصل معنا',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 24),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xff727272).withValues(alpha: 0.50),
                    width: 0.5.w,
                  ),
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/svgs/phone.svg'),
                    13.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'رقم الهاتف',
                            style: Styles.highlightEmphasis.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          3.verticalSpace,
                          Text(
                            '+971 54 454 2141',
                            style: Styles.highlightEmphasis.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(12.sp),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xff9F5A5B),
                          width: 0.5.w,
                        ),
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        'اتصل بنا',
                        style: Styles.highlightStandard.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xff727272).withValues(alpha: 0.50),
                    width: 0.5.w,
                  ),
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/svgs/email.svg'),
                    13.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'الإيميل',
                            style: Styles.highlightEmphasis.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          3.verticalSpace,
                          Text(
                            'nonstop1@mail.com',
                            style: Styles.highlightEmphasis.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(12.sp),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xff9F5A5B),
                          width: 0.5.w,
                        ),
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/svgs/copy.svg",
                            width: 15.w,
                            height: 15.h,
                          ),
                          5.horizontalSpace,
                          Text(
                            'نسخ',
                            style: Styles.highlightStandard.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.w,
                    color: Color(0xff151515).withValues(alpha: 0.41),
                  ),
                  color: Color(0xff151515).withValues(alpha: 0.40),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.close, color: Colors.white),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'اكس',
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.chevron_right, color: Color(0xff9F5A5B)),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.w,
                    color: Color(0xff151515).withValues(alpha: 0.41),
                  ),
                  color: Color(0xff151515).withValues(alpha: 0.40),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.facebook, color: Colors.white),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'فيسبوك',
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.chevron_right, color: Color(0xff9F5A5B)),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.w,
                    color: Color(0xff151515).withValues(alpha: 0.41),
                  ),
                  color: Color(0xff151515).withValues(alpha: 0.40),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.camera_alt, color: Colors.white),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'انستجرام',
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.chevron_right, color: Color(0xff9F5A5B)),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.w,
                    color: Color(0xff151515).withValues(alpha: 0.41),
                  ),
                  color: Color(0xff151515).withValues(alpha: 0.40),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.whatshot, color: Colors.white),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'واتساب',
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.chevron_right, color: Color(0xff9F5A5B)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
