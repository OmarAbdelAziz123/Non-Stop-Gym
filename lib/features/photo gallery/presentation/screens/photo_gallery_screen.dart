import 'dart:math' as math;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:non_stop/core/constants/app_colors.dart';
import 'package:non_stop/core/extensions/navigation_extension.dart';
import 'package:non_stop/core/routing/app_router.dart';
import 'package:non_stop/core/routing/routes_name.dart';
import 'package:non_stop/core/theme/text_colors.dart';
import 'package:non_stop/core/widgets/button/custom_button_widget.dart';
import 'package:non_stop/features/main%20layout/business_logic/main_layout_cubit.dart';
import 'package:non_stop/features/photo%20gallery/bloc/cubit/gallery_cubit.dart';
import 'package:non_stop/features/photo%20gallery/bloc/cubit/gallery_state.dart';

class PhotoGalleryScreen extends StatelessWidget {
  const PhotoGalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GalleryCubit>();
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
                    InkWell(
                      onTap: () {
                        MainLayoutCubit.get(context).changeBottomNavBar(0);
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
                    Text(
                      'photoGallery'.tr(),
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
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  children: [
                    20.verticalSpace,

                    SizedBox(
                      height: 100.h,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: 6,
                        separatorBuilder: (context, index) =>
                            12.horizontalSpace,
                        itemBuilder: (context, index) {
                          final names = [
                            'ليلى حسن',
                            'حازم رمزي',
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
                            "assets/pngs/image4.png",
                          ];
                          return InkWell(
                            onTap: () {
                              context.pushNamed(
                                Routes.photoGalleryDetailsScreen,
                                arguments: PhotoGalleryDetailsArgs(
                                  image: images[index],
                                  name: names[index],
                                ),
                              );
                            },
                            child: Column(
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
                                    fontFamily: GoogleFonts.cairo().fontFamily,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    50.verticalSpace,
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'addPost'.tr(),
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
                      child: TextFormField(
                        maxLines: 3,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontFamily: GoogleFonts.cairo().fontFamily,
                        ),
                        decoration: InputDecoration(
                          hintText: 'writeYourPostHere'.tr(),
                          hintStyle: Styles.footnoteSemiBold.copyWith(
                            color: AppColors.neutralColor400,
                          ),
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {},
                      ),
                    ),

                    16.verticalSpace,

                    BlocBuilder<GalleryCubit, GalleryState>(
                      buildWhen: (previous, current) =>
                          current is PickImageErrorState ||
                          current is PickImageSuccessState,
                      builder: (context, state) {
                        return InkWell(
                          onTap: () {
                            cubit.pickFile();
                          },
                          child: Container(
                            padding: EdgeInsets.all(20.w),
                            decoration: BoxDecoration(
                              color: const Color(0xff2A1A2C),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: cubit.selectedFile != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(12.r),
                                    child: Image.file(
                                      cubit.selectedFile!,
                                      width: double.infinity,
                                      height: 200.h,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.image_outlined,
                                        color: AppColors.neutralColor400,
                                        size: 40.sp,
                                      ),
                                      12.verticalSpace,
                                      Text(
                                        'uploadYourImageHere'.tr(),
                                        style: Styles.footnoteSemiBold.copyWith(
                                          color: AppColors.neutralColor400,
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        );
                      },
                    ),

                    24.verticalSpace,
                    CustomButtonWidget(
                      onPressed: () {},
                      text: 'publish'.tr(),
                      color: const Color(0xff9F5A5B),
                      textStyle: Styles.highlightBold.copyWith(
                        color: Colors.white,
                      ),
                      borderRadius: 12.r,
                      height: 56.h,
                    ),

                    // 20.verticalSpace,
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
