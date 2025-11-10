import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:non_stop/core/constants/app_colors.dart';
import 'package:non_stop/core/constants/app_styles.dart';
import 'package:non_stop/core/constants/hex_colors.dart';

class CustomRowWithCheckWidget extends StatelessWidget {
  const CustomRowWithCheckWidget({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10.w,
      children: [
        Icon(Icons.check, color: hexToColor('#9F5A5B'), size: 16.sp),
        Text(
          text,
          style: Styles.captionSemiBold.copyWith(
            color: AppColors.neutralColor300,
          ),
        ),
      ],
    );
  }
}