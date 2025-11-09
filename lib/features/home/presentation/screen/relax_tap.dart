import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:non_stop/core/theme/app_colors.dart';
import 'package:non_stop/core/theme/text_colors.dart';
import 'package:non_stop/core/widgets/button/custom_button_widget.dart';
import 'package:non_stop/features/home/bloc/cubit/home_cubit.dart';
import 'package:non_stop/features/home/presentation/widgets/calender_widget.dart';
import 'package:non_stop/features/home/presentation/widgets/time_slots_widget.dart';

class RelaxTap extends StatelessWidget {
  const RelaxTap({
    super.key,
    required this.times,
    required this.selectedTimeSlot,
  });

  final List<List<String>> times;
  final String? selectedTimeSlot;

  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<HomeCubit>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 21),
          child: Text(
            'المواعيد المتاحة',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        CalenderWidget(homeCubit: homeCubit),

        TimeSlotsWidget(times: times, selectedTimeSlot: selectedTimeSlot),
        Image.asset("assets/pngs/about_us.png"),
        SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            style: Styles.contentRegular.copyWith(
              color: AppColors.neutralColor200,
            ),
            'نحن نادي Non-stop مشروع رياضي متكامل يقع في برج العبد الكريم ويخدم موظفي وموظفات اكثر من ٢٠ شركه من مختلف القطاعات. تأسس النادي لتوفير بيئه مرنه وصحيه تساعد الموظفين علي تحقيق التوازن بين العمل والحياه. وتعزز من صحتهم الجسديه والذهنيه.',
          ),
        ),
        SizedBox(height: 8),

        Image.asset("assets/pngs/eyes.png"),
        SizedBox(height: 8),

        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            style: Styles.contentRegular.copyWith(
              color: AppColors.neutralColor200,
            ),
            'ان نكون الخيار الاول والمفضل للموظفين والموظفات في بيئه العمل العصريه، من خلال تقديم تجربه رياضيه تجمع بين الراحه، والتنوع، وتسهم في رفع جوده الحياه والصحه العامه.',
          ),
        ),
        SizedBox(height: 15.h),
        CustomButtonWidget(
          margin: EdgeInsets.only(right: 17.sp),
          onPressed: () {},
          text: 'المزيد عنا',
          textStyle: Styles.contentRegular.copyWith(
            color: AppColors.neutralColor100,
          ),
          color: const Color(0xFF9F5A5B),
          height: 56.h,
        ),
        20.verticalSpace,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 17.w),
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
        44.verticalSpace,
        Image.asset("assets/pngs/room.png"),
      ],
    );
  }
}
