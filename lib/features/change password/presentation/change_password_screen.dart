import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:non_stop/core/constants/app_styles.dart';
import 'package:non_stop/core/theme/theme.dart';
import 'package:non_stop/core/widgets/button/custom_button_widget.dart';
import 'package:non_stop/core/widgets/custom_app_bar.dart';

import '../../../core/widgets/text_field/custom_text_form_field_widget.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: linearGradient),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const CustomAppBar(title: "كلمة السر"),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 15.sp,
                    children: [
                      Text(
                        "كلمة المرور الجديدة",
                        style: Styles.contentRegular.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      const CustomTextFormFieldWidget(
                        labelText: 'اسم المستخدم',

                        hintText: "قم بإدخال كلمة المرور الجديدة الخاصة بك هنا",
                      ),
                      Text(
                        "تأكيد كلمة المرور الجديدة",
                        style: Styles.contentRegular.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      const CustomTextFormFieldWidget(
                        labelText: 'اسم المستخدم',

                        hintText: "قم بإدخال كلمة المرور الجديدة الخاصة بك هنا",
                      ),
                    ],
                  ),
                ),
              ),
              CustomButtonWidget(text: "حفظ", onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
