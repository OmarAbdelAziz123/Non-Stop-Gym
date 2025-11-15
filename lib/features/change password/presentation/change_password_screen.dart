import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:non_stop/core/constants/app_colors.dart';
import 'package:non_stop/core/constants/app_styles.dart';
import 'package:non_stop/core/theme/theme.dart';
import 'package:non_stop/core/widgets/button/custom_button_widget.dart';
import 'package:non_stop/core/widgets/custom_app_bar.dart';
import 'package:non_stop/features/profile/bloc/cubit/profile_cubit.dart';
import 'package:non_stop/features/profile/presentation/widgets/profile_card.dart';

import '../../../core/widgets/text_field/custom_text_form_field_widget.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  bool _isObscure = true;
  bool _isObscure2 = true;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    final cubit = context.read<ProfileCubit>();
    if (cubit.profileData == null) {
      cubit.fetchProfile();
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _toggleObscure() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  void _toggleObscure2() {
    setState(() {
      _isObscure2 = !_isObscure2;
    });
  }

  bool get _isPasswordValid {
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();
    return password.length >= 8 &&
        password.contains(RegExp(r'[0-9]')) &&
        password.contains(RegExp(r'[a-zA-Z]')) &&
        password == confirmPassword;
  }

  @override
  Widget build(BuildContext context) {
    final profileCubit = context.read<ProfileCubit>();

    return Container(
      decoration: const BoxDecoration(gradient: linearGradient),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              CustomAppBar(title: "password".tr()),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 30.h),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BlocBuilder<ProfileCubit, ProfileState>(
                          builder: (context, state) {
                            final profile = profileCubit.profileData;
                            if (profile == null) {
                              if (state is ProfileLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                );
                              }
                              return const SizedBox.shrink();
                            }
                            return ProfileCard(profile: profile);
                          },
                        ),
                        24.verticalSpace,
                        Text(
                          "newPassword".tr(),
                          style: Styles.highlightStandard.copyWith(
                            color: AppColors.neutralColor100,
                          ),
                        ),
                        8.verticalSpace,
                        CustomTextFormFieldWidget(
                          backgroundColor: Colors.transparent,
                          controller: _passwordController,
                          obscureText: _isObscure,
                          keyboardType: TextInputType.visiblePassword,
                          hintText: 'enterNewPassword'.tr(),
                          hintStyle: Styles.captionRegular.copyWith(
                            color: AppColors.neutralColor100,
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'passwordIsRequired'.tr();
                            }
                            if (value.trim().length < 8) {
                              return 'passwordMinLength'.tr();
                            }
                            if (!value.contains(RegExp(r'[0-9]'))) {
                              return 'passwordMustContainNumber'.tr();
                            }
                            if (!value.contains(RegExp(r'[a-zA-Z]'))) {
                              return 'passwordMustContainLetter'.tr();
                            }
                            return null;
                          },
                          borderColor: AppColors.neutralColor100,
                          suffixIcon: IconButton(
                            onPressed: _toggleObscure,
                            icon: _isObscure
                                ? Icon(
                                    Icons.remove_red_eye,
                                    color: AppColors.neutralColor100,
                                  )
                                : const Icon(
                                    Icons.visibility_off,
                                    color: Color(0xFF9F5A5B),
                                  ),
                          ),
                        ),
                        25.verticalSpace,
                        Text(
                          "confirmPassword".tr(),
                          style: Styles.highlightStandard.copyWith(
                            color: AppColors.neutralColor100,
                          ),
                        ),
                        8.verticalSpace,
                        CustomTextFormFieldWidget(
                          backgroundColor: Colors.transparent,
                          controller: _confirmPasswordController,
                          obscureText: _isObscure2,
                          keyboardType: TextInputType.visiblePassword,
                          hintText: 'confirmYourPassword'.tr(),
                          hintStyle: Styles.captionRegular.copyWith(
                            color: AppColors.neutralColor100,
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'passwordIsRequired'.tr();
                            }
                            if (value.trim() != _passwordController.text.trim()) {
                              return 'passwordsDoNotMatch'.tr();
                            }
                            return null;
                          },
                          borderColor: AppColors.neutralColor100,
                          suffixIcon: IconButton(
                            onPressed: _toggleObscure2,
                            icon: _isObscure2
                                ? Icon(
                                    Icons.remove_red_eye,
                                    color: AppColors.neutralColor100,
                                  )
                                : const Icon(
                                    Icons.visibility_off,
                                    color: Color(0xFF9F5A5B),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              16.verticalSpace,
              BlocConsumer<ProfileCubit, ProfileState>(
                listenWhen: (previous, current) =>
                    current is ProfileChangePasswordSuccess ||
                    current is ProfileChangePasswordFailure,
                listener: (context, state) {
                  if (state is ProfileChangePasswordSuccess) {
                    _passwordController.clear();
                    _confirmPasswordController.clear();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                    Navigator.pop(context);
                  } else if (state is ProfileChangePasswordFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                },
                buildWhen: (previous, current) =>
                    current is ProfileChangePasswordLoading ||
                    current is ProfileChangePasswordFailure ||
                    current is ProfileChangePasswordSuccess,
                builder: (context, state) {
                  final isLoading = state is ProfileChangePasswordLoading;
                  return Padding(
                    padding:
                        EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 16),
                    child: CustomButtonWidget(
                      textColor: Colors.white,
                      text: "save".tr(),
                      isLoading: isLoading,
                      onPressed: isLoading
                          ? null
                          : () {
                              if (!(_formKey.currentState?.validate() ?? false)) {
                                return;
                              }
                              if (_isPasswordValid) {
                                profileCubit.changePassword(
                                  newPassword: _passwordController.text.trim(),
                                  confirmPassword:
                                      _confirmPasswordController.text.trim(),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text('pleaseCheckConditions'.tr()),
                                  ),
                                );
                              }
                            },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
