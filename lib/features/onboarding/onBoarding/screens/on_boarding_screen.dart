import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:non_stop/core/cache_helper/cache_helper.dart';
import 'package:non_stop/core/cache_helper/cache_keys.dart';
import 'package:non_stop/core/constants/app_colors.dart';
import 'package:non_stop/core/constants/app_styles.dart';
import 'package:non_stop/core/extensions/navigation_extension.dart';
import 'package:non_stop/core/routing/routes_name.dart';
import 'package:non_stop/core/widgets/button/custom_button_widget.dart';
import 'package:non_stop/features/onboarding/onBoarding/Bloc/on_boarding_cubit.dart';

import '../Bloc/on_boarding_states.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    OnBoardingCubit onBoardingCubit = BlocProvider.of<OnBoardingCubit>(context);
    void animateToPage(int index) async {
      await onBoardingCubit.pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
      onBoardingCubit.changeOnBoardingIndex(index);
    }

    return BlocBuilder<OnBoardingCubit, OnBoardingStates>(
      builder: (context, state) {
        return PopScope(
          canPop: false,
          child: Scaffold(
            body: SafeArea(
              child: PageView.builder(
                itemCount: onBoardingCubit.onBoardingImageUrls.length,
                controller: onBoardingCubit.pageController,
                onPageChanged: (index) {
                  onBoardingCubit.changeOnBoardingIndex(index);
                },
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(20.sp),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          onBoardingCubit.onBoardingImageUrls[index],
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: TextButton(
                            onPressed: () {
                              CacheHelper.saveData(
                                key: CacheKeys.isFirstOpen,
                                value: true,
                              );
                              context.pushNamedAndRemoveUntil(
                                Routes.welcomeScreen,
                              );
                            },
                            child: Text(
                              'skip'.tr(),
                              style: Styles.contentEmphasis.copyWith(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.primaryColor900,
                              ),
                            ),
                          ),
                        ),

                        Spacer(),
                        DotsIndicator(
                          dotsCount: onBoardingCubit.onBoardingImageUrls.length,
                          position: onBoardingCubit.onBoardingIndex.toDouble(),
                          decorator: DotsDecorator(
                            activeColor: AppColors.primaryColor900,

                            color: Color(0xff7E7E7E),
                            size: Size(30.r, 5.r),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            activeSize: Size(30.r, 5.r),
                            activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                          ),
                        ),

                        Text(
                          onBoardingCubit.onBoardingTitleStart[onBoardingCubit
                              .onBoardingIndex],
                          style: Styles.contentEmphasis.copyWith(
                            color: Colors.white,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        SizedBox(height: 10.h),
                        Text(
                          onBoardingCubit.onBoardingDescriptions[onBoardingCubit
                              .onBoardingIndex],
                          style: Styles.captionBold.copyWith(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: 48.h),
                        CustomButtonWidget(
                          iconData: Icons.arrow_back_ios,

                          textColor: Colors.white,
                          text:
                              onBoardingCubit.onBoardingIndex ==
                                  onBoardingCubit.onBoardingImageUrls.length - 1
                              ? 'startNow'.tr()
                              : 'next'.tr(),
                          onPressed: () async {
                            if (onBoardingCubit.onBoardingIndex ==
                                onBoardingCubit.onBoardingImageUrls.length -
                                    1) {
                              await CacheHelper.saveData(
                                key: CacheKeys.isFirstOpen,
                                value: true,
                              );
                              context.pushNamedAndRemoveUntil(
                                Routes.loginScreen,
                              );
                            } else {
                              animateToPage(
                                onBoardingCubit.onBoardingIndex + 1,
                              );
                            }
                          },
                        ),
                        SizedBox(height: 20.h),
                        Align(
                          alignment: Alignment.center,
                          child: TextButton(
                            onPressed: () {
                              context.pushNamedAndRemoveUntil(
                                Routes.welcomeScreen,
                              );
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'login'.tr(),
                                  style: Styles.contentEmphasis.copyWith(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                    decoration: TextDecoration.underline,
                                    decorationColor: AppColors.primaryColor900,
                                  ),
                                ),
                                SizedBox(width: 4.w),
                                Icon(
                                  Icons.arrow_forward_ios,

                                  size: 14.sp,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
