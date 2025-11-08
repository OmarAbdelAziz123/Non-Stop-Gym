import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:non_stop/core/constants/app_styles.dart';

class CustomTextContainer extends StatelessWidget {
  final String? text;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;

  const CustomTextContainer({
    super.key,
    this.text,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.r),
        color: backgroundColor ?? Colors.transparent,
        border: Border.all(color: borderColor ?? Colors.black, width: 1.w),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: 8.h,
          bottom: 8.h,
          left: 12.w,
          right: 12.w,
        ),
        child: Text(
          text ?? "",
          style: Styles.footnoteRegular.copyWith(
            color: textColor ?? Colors.black,
          ),
        ),
      ),
    );
  }
}
