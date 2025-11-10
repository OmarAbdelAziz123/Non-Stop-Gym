import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:non_stop/common/extensions/build_context_extensions.dart';
import 'package:non_stop/core/constants/app_colors.dart';
import 'package:non_stop/core/constants/app_styles.dart';

class MoreAboutUsScreen extends StatelessWidget {
  const MoreAboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color(0xff160618)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SafeArea(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 15.h,
                  ),
                  child: Row(
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
                        'معلومات عنا',
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
                ),
              ),
              20.verticalSpace,

              Image.asset("assets/pngs/about_us.png"),
              8.verticalSpace,
              Padding(
                padding: EdgeInsets.all(15.w),
                child: Text(
                  'نحن نادي Non-stop مشروع رياضي متكامل يقع في برج العبد الكريم ويخدم موظفي وموظفات اكثر من ٢٠ شركه من مختلف القطاعات. تأسس النادي لتوفير بيئه مرنه وصحيه تساعد الموظفين علي تحقيق التوازن بين العمل والحياه. وتعزز من صحتهم الجسديه والذهنيه.',
                  style: Styles.contentRegular.copyWith(
                    color: AppColors.neutralColor200,
                  ),
                ),
              ),
              8.verticalSpace,

              Image.asset("assets/pngs/eyes.png"),
              8.verticalSpace,
              Padding(
                padding: EdgeInsets.all(15.w),
                child: Text(
                  'ان نكون الخيار الاول والمفضل للموظفين والموظفات في بيئه العمل العصريه، من خلال تقديم تجربه رياضيه تجمع بين الراحه، والتنوع، وتسهم في رفع جوده الحياه والصحه العامه.',
                  style: Styles.contentRegular.copyWith(
                    color: AppColors.neutralColor200,
                  ),
                ),
              ),
              8.verticalSpace,

              Image.asset("assets/pngs/value.png"),
              8.verticalSpace,
              buildNumberedSection(
                items: [
                  'تعزيز نمط الحياة الصحي في بيئة العمل'
                      'تقديم خدمات رياضية مرنة لكل الأعمار والمستويات',
                  'تجهيز النادي بأحدث الأجهزة والمرافق',
                  'بناء شراكات مع شركات البرج لخدمة موظفيها',
                  'رفع إنتاجية الموظفين وتقليل التوتر عبر برامج رياضية واستشفائية',
                  'ضمان الخصوصية من خلال مرافق وأوقات منفصلة للرجال والنساء',
                ],
              ),
              8.verticalSpace,

              Image.asset("assets/pngs/club.png"),
              8.verticalSpace,
              buildNumberedSection(
                items: [
                  'الصحة: الاهتمام بالصحة الجسدية والذهنية',
                  'المرونة: تقديم خدمات تناسب الجداول المختلفة والاحتياجات المتنوعة',
                  'الخصوصية: مراعاة خصوصية الرجال والنساء في جميع المرافق',
                  'الاحترافية: تقديم خدمات عالية الجودة بتجهيزات حديثة',
                  'التكامل: خلق بيئة متكاملة تدعم رفاهية الموظف داخل مكان العمل',
                ],
              ),
              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNumberedSection({required List<String> items}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        children: List.generate(
          items.length,
          (index) => Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 28.w,
                  height: 28.w,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor900,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: Styles.contentRegular.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                12.horizontalSpace,
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 4.h),
                    child: Text(
                      items[index],
                      style: Styles.contentRegular.copyWith(
                        color: AppColors.neutralColor200,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
