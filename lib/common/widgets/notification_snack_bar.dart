import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:non_stop/core/constants/app_colors.dart';
import 'package:non_stop/core/constants/app_styles.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

/// A centralized service for showing top notification snackbars.
///
/// Displays a customizable success-style snackbar for app-wide notifications.
/// Supports both local and push notification messages.
///
/// Example:
/// ```dart
/// NotificationSnackBar.show(
///   context: context,
///   title: 'New Message',
///   remoteMessage: message,
/// );
/// ```
class NotificationSnackBar {
  NotificationSnackBar._(); // prevent instantiation

  /// Shows a beautiful, customizable top snackbar.
  static void show({
    required BuildContext context,
    required String title,
    required RemoteMessage remoteMessage,
    bool persistent = false,
    void Function(AnimationController controller)? onAnimationControllerInit,
  }) {
    final overlay = Overlay.of(context);

    final String? body = remoteMessage.data["body"];

    showTopSnackBar(
      overlay,
      CustomSnackBar.success(
        message: "$title\n${body ?? ''}",

        /// 🎨 Background color (theme-based)
        backgroundColor: AppColors.neutralColor200,

        /// 🧾 Text style (bold + theme colors)
        textStyle: Styles.contentBold.copyWith(
          color: AppColors.primaryColor800,
        ),

        /// 🧩 Rounded corners & shadow
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],

        /// 🕹 Padding inside the snackbar
        messagePadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),

        /// 🔔 Custom icon for notifications
        icon: Padding(
          padding: EdgeInsetsDirectional.only(end: 18.w, start: 18.w),
          child: Icon(
            Icons.notifications,
            color: AppColors.primaryColor900,
            size: 20.sp,
          ),
        ),
      ),

      /// 🧭 Animation and dismissal options
      dismissDirection: [
        DismissDirection.vertical,
        DismissDirection.horizontal,
      ],
      curve: Curves.easeOutBack,
      displayDuration: const Duration(seconds: 3),
      dismissType: DismissType.onTap,
      persistent: persistent,
      onAnimationControllerInit: onAnimationControllerInit,
    );
  }
}
