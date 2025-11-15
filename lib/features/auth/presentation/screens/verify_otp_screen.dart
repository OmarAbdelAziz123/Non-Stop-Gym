import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:non_stop/core/constants/app_colors.dart';
import 'package:non_stop/core/constants/app_styles.dart';
import 'package:non_stop/core/extensions/navigation_extension.dart';
import 'package:non_stop/core/routing/routes_name.dart';
import 'package:non_stop/core/widgets/button/custom_button_widget.dart';
import 'package:non_stop/features/auth/business_logic/auth_cubit.dart';
import 'package:non_stop/features/auth/presentation/widgets/verify_otp_form_widget.dart';

class VerifyOTPScreen extends StatelessWidget {
  // const VerifyOTPScreen({super.key, required this.email, required this.type});
  const VerifyOTPScreen({super.key, required this.arguments});
  // final String email;
  // final String type
  final Map<String, dynamic> arguments;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    cubit.startTimer();

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
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          170.verticalSpace,
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              ShaderMask(
                                shaderCallback: (bounds) =>
                                    const LinearGradient(
                                      colors: [
                                        Color(0xFFC8938D),
                                        Color(0xFF8E4347),
                                      ],
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
                                    Text(
                                      'verificationCode'.tr(),
                                      style: Styles.heading1.copyWith(
                                        color: AppColors.neutralColor100,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    6.verticalSpace,
                                    Text(
                                      'codeSentToEmail'.tr(),
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
                          40.verticalSpace,
                          const VerifyOtpFormWidget(),
                          200.verticalSpace,
                          BlocBuilder<AuthCubit, AuthState>(
                            buildWhen: (previous, current) =>
                                current is ResendTimerUpdatedState,
                            builder: (context, state) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    cubit.canResend
                                        ? 'didntReceiveCode'.tr()
                                        : 'codeWillExpireIn'.tr() + ' (${cubit.remainingSeconds} ${'seconds'.tr()})',
                                    style: Styles.contentRegular.copyWith(
                                      color: AppColors.neutralColor100,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: cubit.canResend
                                        ? cubit.resendCode
                                        : null,
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.only(
                                        left: 6.w,
                                        top: 18.w,
                                        bottom: 18.w,
                                      ),
                                      minimumSize: Size.zero,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      foregroundColor: cubit.canResend
                                          ? const Color(0xFF9F5A5B)
                                          : AppColors.neutralColor400,
                                    ),
                                    child: Text(
                                      'resend'.tr(),
                                      style: Styles.contentRegular.copyWith(
                                        color: cubit.canResend
                                            ? const Color(0xFF9F5A5B)
                                            : AppColors.neutralColor400,
                                        decoration: cubit.canResend
                                            ? TextDecoration.underline
                                            : TextDecoration.none,
                                        decorationThickness: 1.5.w,
                                        decorationColor: const Color(
                                          0xFF9F5A5B,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          18.verticalSpace,
                          BlocConsumer<AuthCubit, AuthState>(
                            listenWhen: (previous, current) =>
                                current is AuthVerifyOtpSuccess ||
                                current is AuthVerifyOtpFailure ||
                                (current is AuthForgetPasswordSuccess &&
                                    current.isResend),
                            listener: (context, state) {
                              if (state is AuthVerifyOtpSuccess) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(state.message)),
                                );
                                if (state.flowType == 'password_reset') {
                                  context.pushNamed(Routes.createNewPasswordScreen);
                                } else {
                                  context.pushNamedAndRemoveUntil(
                                    Routes.loginScreen,
                                  );
                                }
                              } else if (state is AuthVerifyOtpFailure) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(state.message)),
                                );
                              } else if (state is AuthForgetPasswordSuccess &&
                                  state.isResend) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(state.message)),
                                );
                              }
                            },
                            buildWhen: (previous, current) =>
                                current is CodeChangedState ||
                                current is AuthVerifyOtpLoading ||
                                current is AuthVerifyOtpFailure ||
                                current is AuthVerifyOtpSuccess,
                            builder: (context, state) {
                              final isLoading = state is AuthVerifyOtpLoading;
                              return CustomButtonWidget(
                                onPressed: !cubit.isCodeComplete || isLoading
                                    ? null
                                    : () {
                                        cubit.verifyOtpCode(email: arguments['email'], type: arguments['type']);
                                      },
                                text: 'confirm'.tr(),
                                isLoading: isLoading,
                                textStyle: Styles.contentRegular.copyWith(
                                  color: AppColors.neutralColor100,
                                ),
                                color: const Color(0xFF9F5A5B),
                                height: 56.h,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 12.h,
                right: 18.w,
                child: Container(
                  width: 34.w,
                  height: 34.h,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.neutralColor200,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back,
                      color: AppColors.neutralColor100,
                      size: 18.sp,
                    ),
                    padding: EdgeInsets.all(8.sp),
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
