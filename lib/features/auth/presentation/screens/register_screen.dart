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
                                      'اهلا بك في تطبيق  نادي \n Non-stop ',
                                      style: Styles.heading1.copyWith(
                                        color: AppColors.neutralColor100,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    6.verticalSpace,
                                    Text(
                                      'الرجاء إدخال رقم جوالك اوايميلك وسنرسل رمز التحقق إليه',
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
                                    "اسم المستخدم",
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
                                        "قم بإدخال اسم المستخدم الخاصة بك",
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
                                    "رقم الهاتف",
                                    style: Styles.highlightStandard.copyWith(
                                      color: AppColors.neutralColor100,
                                    ),
                                  ),
                                  8.verticalSpace,
                                  CustomTextFormFieldWidget(
                                    controller: context
                                        .read<AuthCubit>()
                                        .phoneController,
                                    keyboardType: TextInputType.phone,
                                    borderColor: AppColors.neutralColor100,
                                    borderRadius: 6.r,
                                    backgroundColor: Colors.transparent,
                                    hintText: "قم بإدخال رقم الهاتف الخاصة بك",
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
                                    "البريد الإلكتروني",
                                    style: Styles.highlightStandard.copyWith(
                                      color: AppColors.neutralColor100,
                                    ),
                                  ),
                                  8.verticalSpace,
                                  CustomTextFormFieldWidget(
                                    backgroundColor: Colors.transparent,
                                    controller: cubit.emailController,
                                    obscureText: cubit.isObscure,
                                    keyboardType: TextInputType.emailAddress,
                                    hintText:
                                        'قم بإدخال بريدك الإلكتروني الخاصة بك',
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
                                  12.verticalSpace,
                                  BlocBuilder<AuthCubit, AuthState>(
                                    buildWhen: (previous, current) =>
                                        current is ToggleCheckboxState,
                                    builder: (context, state) {
                                      return Row(
                                        children: [
                                          Transform.scale(
                                            scale: 1.5,
                                            child: Checkbox(
                                              value: cubit.isCheck,
                                              onChanged: (value) {
                                                cubit.toggleCheckbox();
                                              },
                                              activeColor: const Color(
                                                0xFF9F5A5B,
                                              ),
                                              checkColor:
                                                  AppColors.neutralColor100,
                                              side: BorderSide(
                                                color:
                                                    AppColors.neutralColor100,
                                                width: 1.w,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4.r),
                                              ),
                                              visualDensity:
                                                  VisualDensity.compact,
                                              materialTapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                            ),
                                          ),
                                          10.horizontalSpace,
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                top: 4.0,
                                              ),
                                              child: Text(
                                                "أوافق على سياسة الخصوصية و شروط الخدمة",
                                                style: Styles.captionRegular
                                                    .copyWith(
                                                      color: AppColors
                                                          .neutralColor100,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                ' لدي حساب بالفعل ؟',
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
                                      ' تسجيل دخول',
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
                          CustomButtonWidget(
                            onPressed: () {
                              context.pushNamed(Routes.verifyOTPScreen);
                            },
                            text: 'طلب OTP',
                            textStyle: Styles.contentRegular.copyWith(
                              color: AppColors.neutralColor100,
                            ),
                            color: const Color(0xFF9F5A5B),
                            height: 56.h,
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
