import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:non_stop/core/constants/app_colors.dart';
import 'package:non_stop/core/constants/app_styles.dart';
import 'package:non_stop/core/extensions/navigation_extension.dart';
import 'package:non_stop/core/routing/routes_name.dart';
import 'package:non_stop/core/widgets/button/custom_button_widget.dart';
import 'package:non_stop/core/widgets/text_field/custom_text_form_field_widget.dart';
import 'package:non_stop/features/auth/business_logic/auth_cubit.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
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
                          150.verticalSpace,
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
                                      'welcomeToApp'.tr(),
                                      style: Styles.heading1.copyWith(
                                        color: AppColors.neutralColor100,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    6.verticalSpace,
                                    Text(
                                      'enterPhoneOrEmailForVerification'.tr(),
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
                          20.verticalSpace,
                          Form(
                            key: cubit.formKey,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 18.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "username".tr(),
                                    style: Styles.highlightStandard.copyWith(
                                      color: AppColors.neutralColor100,
                                    ),
                                  ),
                                  8.verticalSpace,
                                  CustomTextFormFieldWidget(
                                    controller: context
                                        .read<AuthCubit>()
                                        .nameController,
                                    keyboardType: TextInputType.text,
                                    borderColor: AppColors.neutralColor100,
                                    borderRadius: 6.r,
                                    backgroundColor: Colors.transparent,
                                    hintText:
                                        "enterYourUsername".tr(),
                                    hintStyle: Styles.captionRegular,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'nameRequired'.tr();
                                      }
                                      return null;
                                    },
                                  ),
                                  16.verticalSpace,

                                  Text(
                                    "phoneNumber".tr(),
                                    style: Styles.highlightStandard.copyWith(
                                      color: AppColors.neutralColor100,
                                    ),
                                  ),
                                  8.verticalSpace,
                                  CustomTextFormFieldWidget(
                                    controller: cubit.phoneController,
                                    keyboardType: TextInputType.phone,
                                    borderColor: AppColors.neutralColor100,
                                    borderRadius: 6.r,
                                    backgroundColor: Colors.transparent,
                                    hintText:
                                        "enterYourPhoneNumber".tr(),
                                    hintStyle: Styles.captionRegular,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'phoneNumberIsRequired'.tr();
                                      }
                                      return null;
                                    },
                                  ),
                                  16.verticalSpace,
                                  Text(
                                    "email".tr(),
                                    style: Styles.highlightStandard.copyWith(
                                      color: AppColors.neutralColor100,
                                    ),
                                  ),
                                  8.verticalSpace,
                                  CustomTextFormFieldWidget(
                                    backgroundColor: Colors.transparent,
                                    controller: cubit.emailController,
                                    obscureText: false,
                                    keyboardType: TextInputType.emailAddress,
                                    hintText:
                                        'enterYourEmail'.tr(),
                                    hintStyle: Styles.captionRegular.copyWith(
                                      color: AppColors.neutralColor100,
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'emailRequired'.tr();
                                      }
                                      return null;
                                    },
                                    borderColor: AppColors.neutralColor100,
                                  ),
                                  16.verticalSpace,
                                  Text(
                                    "gender".tr(),
                                    style: Styles.highlightStandard.copyWith(
                                      color: AppColors.neutralColor100,
                                    ),
                                  ),
                                  8.verticalSpace,
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12.w,
                                      vertical: 4.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(6.r),
                                      border: Border.all(
                                        color: AppColors.neutralColor100,
                                      ),
                                    ),
                                    child: DropdownButtonFormField<String>(
                                      value: cubit.genderController.text
                                          .toLowerCase()
                                          .contains('female')
                                          ? 'female'
                                          : 'male',
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                      items: [
                                        DropdownMenuItem(
                                          value: 'male',
                                          child: Text('male'.tr()),
                                        ),
                                        DropdownMenuItem(
                                          value: 'female',
                                          child: Text('female'.tr()),
                                        ),
                                      ],
                                      style: Styles.contentRegular.copyWith(
                                        color: AppColors.neutralColor100,
                                      ),
                                      dropdownColor: const Color(0xFF170313),
                                      icon: Icon(
                                        Icons.keyboard_arrow_down,
                                        color: AppColors.neutralColor100,
                                      ),
                                      onChanged: (value) {
                                        cubit.genderController.text =
                                            value ?? 'male';
                                      },
                                    ),
                                  ),
                                  16.verticalSpace,
                                  Text(
                                    "password".tr(),
                                    style: Styles.highlightStandard.copyWith(
                                      color: AppColors.neutralColor100,
                                    ),
                                  ),
                                  8.verticalSpace,
                                  BlocBuilder<AuthCubit, AuthState>(
                                    buildWhen: (previous, current) =>
                                        current is TogglePasswordState,
                                    builder: (context, state) {
                                      return CustomTextFormFieldWidget(
                                        controller: cubit.passwordController,
                                        obscureText: cubit.isObscure,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        backgroundColor: Colors.transparent,
                                        hintText:
                                            'enterYourPassword'.tr(),
                                        hintStyle: Styles.captionRegular,
                                        validator: (value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return 'passwordIsRequired'.tr();
                                          }
                                          if (value.trim().length < 8) {
                                            return 'passwordMinLength'.tr();
                                          }
                                          return null;
                                        },
                                        onChanged: (_) => cubit
                                            .validatePassword(),
                                        borderColor:
                                            AppColors.neutralColor100,
                                        suffixIcon: IconButton(
                                          onPressed: cubit.toggleObscure,
                                          icon: Icon(
                                            cubit.isObscure
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color:
                                                AppColors.neutralColor100,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  16.verticalSpace,
                                  Text(
                                    "confirmPassword".tr(),
                                    style: Styles.highlightStandard.copyWith(
                                      color: AppColors.neutralColor100,
                                    ),
                                  ),
                                  8.verticalSpace,
                                  BlocBuilder<AuthCubit, AuthState>(
                                    buildWhen: (previous, current) =>
                                        current is TogglePasswordState2,
                                    builder: (context, state) {
                                      return CustomTextFormFieldWidget(
                                        controller: cubit.rePasswordController,
                                        obscureText: cubit.isObscure2,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        backgroundColor: Colors.transparent,
                                        hintText:
                                            'confirmYourPassword'.tr(),
                                        hintStyle: Styles.captionRegular,
                                        validator: (value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return 'passwordIsRequired'.tr();
                                          }
                                          if (value.trim() !=
                                              cubit.passwordController.text
                                                  .trim()) {
                                            return 'passwordsDoNotMatch'.tr();
                                          }
                                          return null;
                                        },
                                        onChanged: (_) => cubit
                                            .validatePassword(),
                                        borderColor:
                                            AppColors.neutralColor100,
                                        suffixIcon: IconButton(
                                          onPressed: cubit.toggleObscure2,
                                          icon: Icon(
                                            cubit.isObscure2
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color:
                                                AppColors.neutralColor100,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  12.verticalSpace,
                                  Row(
                                    children: [
                                      Transform.scale(
                                        scale: 1.5,
                                        child: Checkbox(
                                          value: true,
                                          onChanged: null,
                                          activeColor: const Color(
                                            0xFF9F5A5B,
                                          ),
                                          checkColor:
                                              AppColors.neutralColor100,
                                          side: BorderSide(
                                            color: AppColors.neutralColor100,
                                            width: 1.w,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.r),
                                          ),
                                          visualDensity:
                                              VisualDensity.compact,
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                        ),
                                      ),
                                      10.horizontalSpace,
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            top: 4.0,
                                          ),
                                          child: Text(
                                            "agreeToPrivacyPolicy".tr(),
                                            style: Styles.captionRegular
                                                .copyWith(
                                              color:
                                                  AppColors.neutralColor100,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'alreadyHaveAccount'.tr(),
                                style: Styles.contentRegular.copyWith(
                                  color: AppColors.neutralColor100,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  context.pushNamed(Routes.loginScreen);
                                },

                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.only(
                                    left: 6.w,
                                    top: 18.w,
                                    bottom: 18.w,
                                  ),
                                  minimumSize: Size.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  foregroundColor: const Color(0xFF9F5A5B),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      'login'.tr(),
                                      style: Styles.contentRegular.copyWith(
                                        color: const Color(0xFF9F5A5B),
                                        decoration: TextDecoration.underline,
                                        decorationThickness: 1.5.w,
                                        decorationColor: const Color(
                                          0xFF9F5A5B,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          18.verticalSpace,
                          BlocConsumer<AuthCubit, AuthState>(
                            listenWhen: (previous, current) =>
                                current is AuthRegisterSuccess ||
                                current is AuthRegisterFailure,
                            listener: (context, state) {
                              if (state is AuthRegisterSuccess) {
                                final otp = state.response.data?.otp ?? '';
                                cubit.verificationCodeController.text = otp;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      state.response.message ??
                                          'verificationCodeSentSuccessfully'.tr(),
                                    ),
                                  ),
                                );
                                context.pushNamed(
                                  Routes.verifyOTPScreen,
                                  arguments: {
                                    'email': cubit.emailController.text.trim(),
                                    'type': 'registration',
                                  },
                                );
                              } else if (state is AuthRegisterFailure) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(state.message),
                                  ),
                                );
                              }
                            },
                            buildWhen: (previous, current) =>
                                current is AuthRegisterLoading ||
                                current is AuthRegisterFailure ||
                                current is AuthRegisterSuccess,
                            builder: (context, state) {
                              final isLoading = state is AuthRegisterLoading;
                              return CustomButtonWidget(
                                onPressed: isLoading
                                    ? null
                                    : () {
                                        cubit.register();
                                      },
                                text: 'requestOTP'.tr(),
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
