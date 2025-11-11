import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:non_stop/core/constants/app_colors.dart';
import 'package:non_stop/core/constants/app_styles.dart';
import 'package:non_stop/core/theme/theme.dart';
import 'package:non_stop/core/widgets/button/custom_button_widget.dart';
import 'package:non_stop/core/widgets/custom_app_bar.dart';
import 'package:non_stop/features/auth/business_logic/auth_cubit.dart';

import '../../../core/widgets/text_field/custom_text_form_field_widget.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return Container(
      decoration: const BoxDecoration(gradient: linearGradient),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const CustomAppBar(title: "كلمة السر"),

              SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 30.h),
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
                          keyboardType: TextInputType.visiblePassword,
                          hintText: 'قم بإدخال كلمة المرور الخاصة بك ',
                          hintStyle: Styles.captionRegular.copyWith(
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
                            onPressed: () => cubit.toggleObscure(),
                            icon: cubit.isObscure
                                ? Icon(
                                    Icons.remove_red_eye,
                                    color: AppColors.neutralColor100,
                                  )
                                : const Icon(
                                    Icons.visibility_off,
                                    color: Color(0xFF9F5A5B),
                                  ),
                          ),
                        );
                      },
                    ),
                    25.verticalSpace,
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
                          keyboardType: TextInputType.visiblePassword,
                          hintText: 'قم بإدخال تاكيد  كلمة المرور الخاصة بك ',
                          hintStyle: Styles.captionRegular.copyWith(
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
                            onPressed: () => cubit.toggleObscure2(),
                            icon: cubit.isObscure2
                                ? Icon(
                                    Icons.remove_red_eye,
                                    color: AppColors.neutralColor100,
                                  )
                                : const Icon(
                                    Icons.visibility_off,
                                    color: Color(0xFF9F5A5B),
                                  ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Spacer(),
              CustomButtonWidget(
                textColor: Colors.white,
                text: "حفظ",
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
