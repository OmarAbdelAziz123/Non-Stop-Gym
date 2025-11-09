import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:non_stop/core/theme/theme.dart';
import 'package:non_stop/core/widgets/text_field/custom_text_form_field_widget.dart';
import 'package:non_stop/core/widgets/custom_app_bar.dart';
import 'package:non_stop/features/profile/presentation/widgets/profile_card.dart';
import 'package:non_stop/features/profile/presentation/screen/profile_screen.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: linearGradient),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const CustomAppBar(title: 'تعديل الملف الشخصي'),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    spacing: 15.sp,
                    children: [
                      ProfileCard(isEditProfile: true),
                      10.verticalSpace,
                      const CustomTextFormFieldWidget(
                        labelText: 'اسم المستخدم',

                        hintText: 'محمد جوده',
                      ),

                      const CustomTextFormFieldWidget(
                        labelText: 'البريد الإلكتروني',
                        hintText: 'UIUX@mohamedguda.com',
                      ),

                      const CustomTextFormFieldWidget(
                        labelText: 'رقم الهاتف',
                        hintText: '01092321355',
                        keyboardType: TextInputType.phone,
                      ),

                      const CustomTextFormFieldWidget(
                        labelText: 'الجنس',
                        hintText: 'ذكر',
                      ),
                    ],
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
