import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:non_stop/core/constants/app_colors.dart';
import 'package:non_stop/core/theme/text_colors.dart';
import 'package:non_stop/core/widgets/text_field/custom_text_form_field_widget.dart';

class PhotoGalleryScreen extends StatefulWidget {
  const PhotoGalleryScreen({super.key});

  @override
  State<PhotoGalleryScreen> createState() => _PhotoGalleryState();
}

class _PhotoGalleryState extends State<PhotoGalleryScreen> {
  List<String> selectedImages = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color(0xff160618)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
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
                    Text(
                      'معرض الصور',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
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
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  children: [
                    20.verticalSpace,

                    SizedBox(
                      height: 100.h,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        separatorBuilder: (context, index) =>
                            12.horizontalSpace,
                        itemBuilder: (context, index) {
                          final names = [
                            'ليلى حسن',
                            'حارم رمزي',
                            'أحمد عادل',
                            'يوسف سليم',
                            'سماء أحمد',
                            'محمد علي',
                          ];
                          final images = [
                            "assets/pngs/image1.png",
                            "assets/pngs/image2.png",
                            "assets/pngs/image3.png",
                            "assets/pngs/image4.png",
                            "assets/pngs/image4.png",
                          ];
                          return Column(
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
                                    image: AssetImage(images[index]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              6.verticalSpace,
                              Text(
                                names[index],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    50.verticalSpace,
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'إضافة منشور',
                        style: Styles.highlightBold.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    20.verticalSpace,
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: const Color(0xff2A1A2C),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: 
                      CustomTextFormFieldWidget(
                        
                        onChanged: (value) {},
                        maxLines: 3,
                        hintStyle: Styles.captionEmphasis.copyWith(
                          color: AppColors.neutralColor400,
                        ),
                      ),
                      // TextField(
                      //   maxLines: 3,
                      //   textAlign: TextAlign.right,
                      //   style: TextStyle(color: Colors.white, fontSize: 14.sp),
                      //   decoration: InputDecoration(
                      //     hintText: 'قم بكتابة منشورتك الخاص بك هنا',
                      //     hintStyle: TextStyle(
                      //       color: Colors.white38,
                      //       fontSize: 14.sp,
                      //     ),
                      //     border: InputBorder.none,
                      //   ),
                      //   onChanged: (value) {},
                      // ),
                    ),

                    16.verticalSpace,

                    if (selectedImages.isNotEmpty)
                      Container(
                        height: 120.h,
                        margin: EdgeInsets.only(bottom: 16.h),
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          reverse: true,
                          itemCount: selectedImages.length,
                          separatorBuilder: (context, index) =>
                              8.horizontalSpace,
                          itemBuilder: (context, index) {
                            return Container(
                              width: 100.w,
                              height: 120.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                image: DecorationImage(
                                  image: FileImage(File(selectedImages[index])),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                    GestureDetector(
                      child: Container(
                        padding: EdgeInsets.all(20.w),
                        decoration: BoxDecoration(
                          color: const Color(0xff2A1A2C),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image_outlined,
                              color: Colors.white38,
                              size: 40.sp,
                            ),
                            12.verticalSpace,
                            Text(
                              'قم برفع الصورة الخاصة بك هنا',
                              style: TextStyle(
                                color: Colors.white38,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    24.verticalSpace,

                    GestureDetector(
                      onTap: () {
                        ('Images: ${selectedImages.length}');
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        decoration: BoxDecoration(
                          color: const Color(0xff9F5A5B),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Center(
                          child: Text(
                            'نشر',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),

                    20.verticalSpace,
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
