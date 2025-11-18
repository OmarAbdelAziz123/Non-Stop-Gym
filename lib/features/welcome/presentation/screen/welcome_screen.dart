import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:non_stop/core/constants/app_colors.dart';
import 'package:non_stop/core/constants/app_styles.dart';
import 'package:non_stop/core/extensions/navigation_extension.dart';
import 'package:non_stop/core/routing/routes_name.dart';
import 'package:non_stop/core/widgets/button/custom_button_widget.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF050317), Color(0xFF170313)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.8],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 150.h),
              Stack(
                alignment: Alignment.center,
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [Color(0xFFC8938D), Color(0xFF8E4347)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ).createShader(bounds),
                    blendMode: BlendMode.srcIn,
                    child: Image.asset(
                      'assets/pngs/logo.png',
                      width: 390.w,
                      height: 156.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                    top: 16.h,
                    child: Column(
                      children: [
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '${'welcomeToClub'.tr()} ',
                                style: Styles.heading1.copyWith(
                                  color: AppColors.neutralColor100,
                                ),
                              ),
                              TextSpan(
                                text: 'Non-Stop',
                                style: Styles.heading1.copyWith(
                                  color: AppColors.neutralColor100,
                                ),
                              ),
                            ],
                          ),
                        ),
                        6.verticalSpace,
                        Text(
                          'chooseRegistrationMethod'.tr(),
                          style: Styles.contentRegular.copyWith(
                            color: AppColors.neutralColor100,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              50.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: Column(
                  children: [
                    CustomButtonWidget(
                      onPressed: () {
                        context.pushNamed(Routes.loginScreen);
                      },
                      text: 'login'.tr(),
                      textStyle: Styles.contentRegular.copyWith(
                        color: AppColors.neutralColor100,
                      ),
                      color: const Color(0xFF9F5A5B),
                      height: 56.h,
                    ),
                    18.verticalSpace,
                    CustomButtonWidget(
                      onPressed: () {
                        context.pushNamed(Routes.registerScreen);
                      },
                      text: 'createAccount'.tr(),
                      textStyle: Styles.contentRegular.copyWith(
                        color: Colors.white,
                      ),
                      color: Colors.transparent,
                      height: 56.h,
                      borderRadius: 8.r,
                      borderSide: BorderSide(color: Colors.white, width: 1.w),
                    ),
                  ],
                ),
              ),
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${'dontWantToCreateAccountNow'.tr()} ',
                    style: Styles.contentRegular.copyWith(
                      color: AppColors.neutralColor100,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.only(
                        left: 6.w,
                        top: 18.w,
                        bottom: 18.w,
                      ),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      foregroundColor: const Color(0xFF9F5A5B),
                    ),
                    child: Row(
                      children: [
                        Text(
                          ' ${'registerAsGuest'.tr()}',
                          style: Styles.contentRegular.copyWith(
                            color: const Color(0xFF9F5A5B),
                            decoration: TextDecoration.underline,
                            decorationThickness: 1.5.w,
                            decorationColor: const Color(0xFF9F5A5B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
