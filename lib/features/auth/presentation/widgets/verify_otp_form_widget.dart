import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:non_stop/core/constants/app_colors.dart';
import 'package:non_stop/core/constants/app_constants.dart';
import 'package:non_stop/core/constants/app_styles.dart';
import 'package:non_stop/core/constants/hex_colors.dart';
import 'package:non_stop/features/auth/business_logic/auth_cubit.dart';
import 'package:pinput/pinput.dart';

class VerifyOtpFormWidget extends StatelessWidget {
  final void Function(String)? onCompleted;

  const VerifyOtpFormWidget({super.key, this.onCompleted});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return Pinput(
      controller: cubit.verificationCodeController,
      length: 4,
      autofocus: true,
      obscureText: false,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      pinAnimationType: PinAnimationType.fade,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(4),
      ],
      onChanged: (pin) {
        cubit.onCodeChanged(pin);
      },
      onCompleted: onCompleted,
      defaultPinTheme: PinTheme(
        width: 49.w,
        height: 54.h,
        textStyle: Styles.contentEmphasis.copyWith(
          color: AppColors.neutralColor100,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.neutralColor100),
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        ),
      ),
      focusedPinTheme: PinTheme(
        width: 49.w,
        height: 54.h,
        textStyle: Styles.contentEmphasis.copyWith(
          color: hexToColor('#9F5A5B'),
        ),
        decoration: BoxDecoration(
          border: Border.all(color: hexToColor('#9F5A5B')),
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        ),
      ),
      validator: (pin) {
        if (pin?.length != 4) {
          return 'enterYourCodeComplete'.tr();
        }
        return null;
      },
      errorTextStyle: Styles.contentEmphasis.copyWith(
        color: AppColors.neutralColor100,
      ),
    );
  }
}
