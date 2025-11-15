import 'dart:math' as math;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:non_stop/core/theme/text_colors.dart';

class PhotoGalleryDetailsScreen extends StatelessWidget {
  final String name;
  final String imagePath;

  const PhotoGalleryDetailsScreen({
    super.key,
    required this.name,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color(0xff160618)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 44.w,
                    height: 44.h,
                    decoration: BoxDecoration(
                      color: const Color(0xff2A1A2C),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Transform.rotate(
                      angle: context.locale.languageCode == 'en' ? math.pi : 0, // 180 degrees (π radians) for English
                      child: SvgPicture.asset(
                        "assets/svgs/Back _con.svg",
                        width: 24.w,
                        height: 24.h,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                ),
              ),

              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  children: [
                    20.verticalSpace,

                    Row(
                      children: [
                        Container(
                          width: 64.w,
                          height: 64.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xff9F5A5B),
                              width: 2,
                            ),
                            image: DecorationImage(
                              image: AssetImage(imagePath),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        16.horizontalSpace,
                        Text(
                          name,
                          style: Styles.featureBold.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),

                    20.verticalSpace,

                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(color: Colors.transparent),
                      child: Text(
                        "ما كنت أتوقع الجيم يصير مكاني المفضل، بس كل تمرينة تثبت لي إن التعب يستاهل، شكراً للجيم اللي غيّرني للأفضل 💪🤍",
                        style: Styles.contentEmphasis.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),

                    30.verticalSpace,

                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: Image.asset(
                        "assets/pngs/gallery_details.png",
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xff2A1A2C),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
