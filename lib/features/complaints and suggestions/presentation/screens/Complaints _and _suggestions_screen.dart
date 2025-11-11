import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:non_stop/core/constants/app_colors.dart';
import 'package:non_stop/core/constants/app_styles.dart';
import 'package:non_stop/core/theme/theme.dart';
import 'package:non_stop/core/widgets/button/custom_button_widget.dart';
import 'package:non_stop/core/widgets/custom_app_bar.dart';
import 'package:non_stop/core/widgets/text_field/custom_text_form_field_widget.dart';

class ComplaintsAndSuggestionsScreen extends StatelessWidget {
  const ComplaintsAndSuggestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: linearGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              const CustomAppBar(title: "شكاوي و اقتراحات"),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 20.h,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "رسالتك",
                          style: Styles.heading2.copyWith(
                            color: AppColors.neutralColor100,
                          ),
                        ),
                        10.verticalSpace,
                        CustomTextFormFieldWidget(
                          hintText: "قم بإدخال رسالتك الخاصة بك هنا",
                          hintStyle: Styles.footnoteSemiboldBold.copyWith(
                            color: AppColors.neutralColor400,
                          ),
                          borderRadius: 10.r,
                          maxLines: 10,
                          borderColor: const Color(
                            0xff151515,
                          ).withValues(alpha: 0.41),
                        ),
                        100.verticalSpace,
                        CustomButtonWidget(
                          textColor: Colors.white,
                          text: "إرسال",
                          onPressed: () {},
                        ),
                      ],
                    ),
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
