import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:non_stop/core/constants/app_colors.dart';
import 'package:non_stop/core/constants/app_styles.dart';
import 'package:non_stop/core/widgets/images/image_widget.dart';

class CustomButtonWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData? iconData;
  final String? imagePath;
  final String? text;
  final Color? color;
  final Color? textColor;
  final Color? imageColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final BorderSide? borderSide;
  final double? elevation;
  final bool? enableShadow;
  final bool? isEnabled;
  final TextStyle? textStyle;
  final List<Color>? gradientColors;
  final List<BoxShadow>? boxShadow;
  final bool isLoading;

  const CustomButtonWidget({
    super.key,
    this.onPressed,
    this.iconData,
    this.imagePath,
    this.imageColor,
    this.text,
    this.color,
    this.textColor,
    this.fontSize = 20,
    this.fontWeight,
    this.width,
    this.textStyle,
    this.height,
    this.margin,
    this.padding,
    this.borderRadius = 8,
    this.borderSide,
    this.elevation,
    this.enableShadow,
    this.isEnabled,
    this.gradientColors,
    this.boxShadow = const [],
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: Container(
        width: width ?? MediaQuery.of(context).size.width * 0.9,
        height: height ?? 53.h,
        margin: margin,
        padding: padding ?? EdgeInsets.symmetric(horizontal: 2.w),
        decoration: BoxDecoration(
          gradient: gradientColors != null
              ? LinearGradient(
                  colors: gradientColors!,
                  end: Alignment.bottomCenter,
                  begin: Alignment.topCenter,
                )
              : null,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: borderSide?.color ?? Colors.transparent),
          color: color ?? const Color(0xff9F5A5B),
          boxShadow:
              boxShadow ??
              [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.3),
                  spreadRadius: -1,
                  blurRadius: 5.sp,
                ),
              ],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (iconData != null)
                Icon(
                  iconData,
                  color: textColor ?? AppColors.primaryColor900,
                  size: 16.sp,
                ),
              if (imagePath != null)
                ImagesWidget(
                  image: imagePath!,
                  color: imageColor ?? AppColors.primaryColor900,
                  fit: BoxFit.scaleDown,
                ),
              if (isLoading)
                SizedBox(
                  width: 20.sp,
                  height: 20.sp,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      textColor ?? AppColors.primaryColor900,
                    ),
                  ),
                ),
              if (isLoading && (text?.isNotEmpty ?? false)) 8.horizontalSpace,
              if (!isLoading || (text?.isNotEmpty ?? false))
                Text(
                  text ?? '',
                  style:
                      textStyle ??
                      Styles.contentEmphasis.copyWith(
                        color: textColor ?? AppColors.primaryColor900,
                        fontSize: fontSize,
                        fontWeight: fontWeight,
                      ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
