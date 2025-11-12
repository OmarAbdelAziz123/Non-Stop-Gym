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
import 'package:non_stop/features/auth/presentation/widgets/custom_text_container_widget.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  const CreateNewPasswordScreen({super.key});

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
                                      'انشاء كلمة مرور جديدة',
                                      style: Styles.heading1.copyWith(
                                        color: AppColors.neutralColor100,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    6.verticalSpace,
                                    Text(
                                      'يرجي إضافة كلمة مرور قوية للحفاظ علي بياناتك',
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
                                    "كلمة المرور",
                                    style: Styles.highlightStandard.copyWith(
                                      color: AppColors.neutralColor100,
                                    ),
                                  ),
                                  8.verticalSpace,
                                  BlocBuilder<AuthCubit, AuthState>(
                                    buildWhen: (previous, current) =>
                                        current is TogglePasswordState ||
                                        current is PasswordValidationState,
                                    builder: (context, state) {
                                      return CustomTextFormFieldWidget(
                                        backgroundColor: Colors.transparent,
                                        controller: cubit.passwordController,
                                        obscureText: cubit.isObscure,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        hintText:
                                            'قم بإدخال كلمة المرور الخاصة بك ',
                                        hintStyle: Styles.captionRegular
                                            .copyWith(
                                              color: AppColors.neutralColor100,
                                            ),
                                        onChanged: (value) {
                                          cubit.validatePassword();
                                        },
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'passwordIsRequired'.tr();
                                          }
                                          return null;
                                        },
                                        borderColor: AppColors.neutralColor100,
                                        suffixIcon: IconButton(
                                          onPressed: () =>
                                              cubit.toggleObscure(),
                                          icon: cubit.isObscure
                                              ? Icon(
                                                  Icons.remove_red_eye,
                                                  color:
                                                      AppColors.neutralColor100,
                                                )
                                              : const Icon(
                                                  Icons.visibility_off,
                                                  color: Color(0xFF9F5A5B),
                                                ),
                                        ),
                                      );
                                    },
                                  ),
                                  20.verticalSpace,
                                  Text(
                                    "تاكيد كلمة المرور",
                                    style: Styles.highlightStandard.copyWith(
                                      color: AppColors.neutralColor100,
                                    ),
                                  ),
                                  8.verticalSpace,
                                  BlocBuilder<AuthCubit, AuthState>(
                                    buildWhen: (previous, current) =>
                                        current is TogglePasswordState2 ||
                                        current is PasswordValidationState,
                                    builder: (context, state) {
                                      return CustomTextFormFieldWidget(
                                        backgroundColor: Colors.transparent,
                                        controller: cubit.rePasswordController,
                                        obscureText: cubit.isObscure2,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        hintText:
                                            'قم بإدخال تاكيد  كلمة المرور الخاصة بك ',
                                        hintStyle: Styles.captionRegular
                                            .copyWith(
                                              color: AppColors.neutralColor100,
                                            ),
                                        onChanged: (value) {
                                          cubit.validatePassword();
                                        },
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'passwordIsRequired'.tr();
                                          }
                                          return null;
                                        },
                                        borderColor: AppColors.neutralColor100,
                                        suffixIcon: IconButton(
                                          onPressed: () =>
                                              cubit.toggleObscure2(),
                                          icon: cubit.isObscure2
                                              ? Icon(
                                                  Icons.remove_red_eye,
                                                  color:
                                                      AppColors.neutralColor100,
                                                )
                                              : const Icon(
                                                  Icons.visibility_off,
                                                  color: Color(0xFF9F5A5B),
                                                ),
                                        ),
                                      );
                                    },
                                  ),
                                  16.verticalSpace,
                                  BlocBuilder<AuthCubit, AuthState>(
                                    buildWhen: (previous, current) =>
                                        current is PasswordValidationState,
                                    builder: (context, state) {
                                      return Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: CustomTextContainer(
                                                  text: "8 حروف علي الاقل",
                                                  backgroundColor:
                                                      cubit.hasMinLength
                                                      ? Color(0xff138855)
                                                      : Color(
                                                          0xff470000,
                                                        ).withValues(
                                                          alpha: 0.36,
                                                        ),
                                                  borderColor:
                                                      cubit.hasMinLength
                                                      ? Color(0xff2C5EA8)
                                                      : AppColors
                                                            .primaryColor400,
                                                  textColor: cubit.hasMinLength
                                                      ? Color(0xffE7DEC0)
                                                      : Color(0xffFF7777),
                                                ),
                                              ),
                                              12.horizontalSpace,
                                              Expanded(
                                                child: CustomTextContainer(
                                                  text:
                                                      "تحتوي على رقم واحد على الأقل",
                                                  backgroundColor:
                                                      cubit.hasNumber
                                                      ? Color(0xff138855)
                                                      : Color(
                                                          0xff470000,
                                                        ).withValues(
                                                          alpha: 0.36,
                                                        ),
                                                  borderColor: cubit.hasNumber
                                                      ? Color(0xff2C5EA8)
                                                      : AppColors
                                                            .primaryColor400,
                                                  textColor: cubit.hasNumber
                                                      ? Color(0xffE7DEC0)
                                                      : Color(0xffFF7777),
                                                ),
                                              ),
                                            ],
                                          ),
                                          12.verticalSpace,
                                          Row(
                                            children: [
                                              Expanded(
                                                child: CustomTextContainer(
                                                  text:
                                                      "كلمتي المرور متطابقتين",
                                                  backgroundColor:
                                                      cubit.passwordsMatch
                                                      ? Color(0xff138855)
                                                      : Color(
                                                          0xff470000,
                                                        ).withValues(
                                                          alpha: 0.36,
                                                        ),
                                                  borderColor:
                                                      cubit.passwordsMatch
                                                      ? Color(0xff2C5EA8)
                                                      : AppColors
                                                            .primaryColor400,
                                                  textColor:
                                                      cubit.passwordsMatch
                                                      ? Color(0xffE7DEC0)
                                                      : Color(0xffFF7777),
                                                ),
                                              ),
                                              12.horizontalSpace,
                                              Expanded(
                                                child: CustomTextContainer(
                                                  text:
                                                      "تحتوي على حرف كبير أو صغير",
                                                  backgroundColor:
                                                      cubit.hasUpperOrLower
                                                      ? Color(0xff138855)
                                                      : Color(
                                                          0xff470000,
                                                        ).withValues(
                                                          alpha: 0.36,
                                                        ),
                                                  borderColor:
                                                      cubit.hasUpperOrLower
                                                      ? Color(0xff2C5EA8)
                                                      : AppColors
                                                            .primaryColor400,
                                                  textColor:
                                                      cubit.hasUpperOrLower
                                                      ? Color(0xffE7DEC0)
                                                      : Color(0xffFF7777),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          95.verticalSpace,
                          BlocConsumer<AuthCubit, AuthState>(
                            listenWhen: (previous, current) =>
                                current is AuthResetPasswordSuccess ||
                                current is AuthResetPasswordFailure,
                            listener: (context, state) {
                              if (state is AuthResetPasswordSuccess) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(state.message)),
                                );
                                context.pushNamedAndRemoveUntil(
                                  Routes.loginScreen,
                                );
                              } else if (state is AuthResetPasswordFailure) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(state.message)),
                                );
                              }
                            },
                            buildWhen: (previous, current) =>
                                current is PasswordValidationState ||
                                current is AuthResetPasswordLoading ||
                                current is AuthResetPasswordFailure ||
                                current is AuthResetPasswordSuccess,
                            builder: (context, state) {
                              final isLoading =
                                  state is AuthResetPasswordLoading;
                              return CustomButtonWidget(
                                onPressed: !cubit.isPasswordValid || isLoading
                                    ? null
                                    : () {
                                        if (cubit.formKey.currentState
                                                ?.validate() ??
                                            false) {
                                          cubit.resetPassword();
                                        }
                                      },
                                text: ' تاكيد',
                                isLoading: isLoading,
                                textStyle: Styles.contentRegular.copyWith(
                                  color: AppColors.neutralColor100,
                                ),
                                color: cubit.isPasswordValid
                                    ? const Color(0xff9f5a5b)
                                    : const Color(0xff9F5A5B)
                                        .withValues(alpha: 0.21),
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
