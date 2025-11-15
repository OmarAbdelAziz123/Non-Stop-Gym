import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:non_stop/core/constants/app_colors.dart';
import 'package:non_stop/core/constants/app_styles.dart';
import 'package:non_stop/core/widgets/button/custom_button_widget.dart';
import 'package:non_stop/features/packages/bloc/cubit/packages_cubit.dart';
import 'package:non_stop/features/packages/data/models/subscription_response.dart';

class GiftsTap extends StatelessWidget {
  const GiftsTap({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PackagesCubit>(
      create: (context) => PackagesCubit()..fetchSubscriptions(),
      child: _GiftsTapContent(),
    );
  }
}

class _GiftsTapContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<PackagesCubit, PackagesState>(
      listenWhen: (previous, current) =>
          current is PackagesSubscribeSuccess ||
          current is PackagesSubscribeFailure,
      listener: (context, state) {
        if (state is PackagesSubscribeSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                style: TextStyle(
                  fontFamily: GoogleFonts.cairo().fontFamily,
                ),
              ),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is PackagesSubscribeFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                style: TextStyle(
                  fontFamily: GoogleFonts.cairo().fontFamily,
                ),
              ),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 4),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
          child: Text(
            'bestOffers'.tr(),
            style: TextStyle(
              color: AppColors.neutralColor100,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.cairo().fontFamily,
            ),
          ),
        ),
        10.verticalSpace,
        BlocBuilder<PackagesCubit, PackagesState>(
          builder: (context, state) {
            if (state is PackagesLoading) {
              return SizedBox(
                height: 180.h,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Color(0xff9F5A5B),
                  ),
                ),
              );
            }

            if (state is PackagesFailure) {
              return SizedBox(
                height: 180.h,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.message,
                        style: Styles.contentRegular.copyWith(
                          color: Colors.red,
                          fontFamily: GoogleFonts.cairo().fontFamily,
                        ),
                      ),
                      8.verticalSpace,
                      TextButton(
                        onPressed: () {
                          context.read<PackagesCubit>().fetchSubscriptions();
                        },
                        child: Text(
                          'retry'.tr(),
                          style: TextStyle(
                            fontFamily: GoogleFonts.cairo().fontFamily,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            final subscriptions = state is PackagesSuccess
                ? state.subscriptions
                : context.read<PackagesCubit>().subscriptions;

            if (subscriptions.isEmpty) {
              return SizedBox(
                height: 180.h,
                child: Center(
                  child: Text(
                    'noPackagesAvailable'.tr(),
                    style: Styles.contentRegular.copyWith(
                      color: AppColors.neutralColor500,
                      fontFamily: GoogleFonts.cairo().fontFamily,
                    ),
                  ),
                ),
              );
            }

            return SizedBox(
              height: 180.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: subscriptions.length,
                itemBuilder: (context, index) {
                  final subscription = subscriptions[index];
                  return Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: _buildSubscriptionCard(context, subscription),
                  );
                },
              ),
            );
          },
        ),
        SizedBox(height: 24.h),
        // Container(
        //   padding: EdgeInsets.symmetric(horizontal: 16.w),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Text(
        //         'تواصل معنا',
        //         style: TextStyle(
        //           fontSize: 22,
        //           fontWeight: FontWeight.bold,
        //           color: Colors.white,
        //         ),
        //       ),
        //       SizedBox(height: 24),
        //       Container(
        //         padding: EdgeInsets.all(16),
        //         decoration: BoxDecoration(
        //           border: Border.all(
        //             color: Color(0xff727272).withValues(alpha: 0.50),
        //             width: 0.5.w,
        //           ),
        //           color: Colors.transparent,
        //           borderRadius: BorderRadius.circular(12),
        //         ),
        //         child: Row(
        //           children: [
        //             SvgPicture.asset('assets/svgs/phone.svg'),
        //             13.horizontalSpace,
        //             Expanded(
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   Text(
        //                     'رقم الهاتف',
        //                     style: Styles.highlightEmphasis.copyWith(
        //                       color: Colors.white,
        //                     ),
        //                   ),
        //                   3.verticalSpace,
        //                   Text(
        //                     '+971 54 454 2141',
        //                     style: Styles.highlightEmphasis.copyWith(
        //                       color: Colors.white,
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             Container(
        //               padding: EdgeInsets.all(12.sp),
        //               decoration: BoxDecoration(
        //                 border: Border.all(
        //                   color: Color(0xff9F5A5B),
        //                   width: 0.5.w,
        //                 ),
        //                 color: Colors.transparent,
        //                 borderRadius: BorderRadius.circular(4.r),
        //               ),
        //               child: Text(
        //                 'اتصل بنا',
        //                 style: Styles.highlightStandard.copyWith(
        //                   color: Colors.white,
        //                 ),
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //       SizedBox(height: 16),
        //       Container(
        //         padding: EdgeInsets.all(16),
        //         decoration: BoxDecoration(
        //           border: Border.all(
        //             color: Color(0xff727272).withValues(alpha: 0.50),
        //             width: 0.5.w,
        //           ),
        //           color: Colors.transparent,
        //           borderRadius: BorderRadius.circular(12),
        //         ),
        //         child: Row(
        //           children: [
        //             SvgPicture.asset('assets/svgs/email.svg'),
        //             13.horizontalSpace,
        //             Expanded(
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   Text(
        //                     'الإيميل',
        //                     style: Styles.highlightEmphasis.copyWith(
        //                       color: Colors.white,
        //                     ),
        //                   ),
        //                   3.verticalSpace,
        //                   Text(
        //                     'nonstop1@mail.com',
        //                     style: Styles.highlightEmphasis.copyWith(
        //                       color: Colors.white,
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             Container(
        //               padding: EdgeInsets.all(12.sp),
        //               decoration: BoxDecoration(
        //                 border: Border.all(
        //                   color: Color(0xff9F5A5B),
        //                   width: 0.5.w,
        //                 ),
        //                 color: Colors.transparent,
        //                 borderRadius: BorderRadius.circular(4.r),
        //               ),
        //               child: Row(
        //                 children: [
        //                   SvgPicture.asset(
        //                     "assets/svgs/copy.svg",
        //                     width: 15.w,
        //                     height: 15.h,
        //                   ),
        //                   5.horizontalSpace,
        //                   Text(
        //                     'نسخ',
        //                     style: Styles.highlightStandard.copyWith(
        //                       color: Colors.white,
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //       SizedBox(height: 16),
        //       Container(
        //         padding: EdgeInsets.all(16),
        //         decoration: BoxDecoration(
        //           border: Border.all(
        //             width: 1.w,
        //             color: Color(0xff151515).withValues(alpha: 0.41),
        //           ),
        //           color: Color(0xff151515).withValues(alpha: 0.40),
        //           borderRadius: BorderRadius.circular(10.r),
        //         ),
        //         child: Row(
        //           children: [
        //             Icon(Icons.close, color: Colors.white),
        //             SizedBox(width: 8),
        //             Expanded(
        //               child: Text(
        //                 'اكس',
        //                 textAlign: TextAlign.start,
        //                 style: TextStyle(color: Colors.white, fontSize: 16),
        //               ),
        //             ),
        //             SizedBox(width: 8),
        //             Icon(Icons.chevron_right, color: Color(0xff9F5A5B)),
        //           ],
        //         ),
        //       ),
        //       SizedBox(height: 8),
        //       Container(
        //         padding: EdgeInsets.all(16),
        //         decoration: BoxDecoration(
        //           border: Border.all(
        //             width: 1.w,
        //             color: Color(0xff151515).withValues(alpha: 0.41),
        //           ),
        //           color: Color(0xff151515).withValues(alpha: 0.40),
        //           borderRadius: BorderRadius.circular(10.r),
        //         ),
        //         child: Row(
        //           children: [
        //             Icon(Icons.facebook, color: Colors.white),
        //             SizedBox(width: 8),
        //             Expanded(
        //               child: Text(
        //                 'فيسبوك',
        //                 textAlign: TextAlign.start,
        //                 style: TextStyle(color: Colors.white, fontSize: 16),
        //               ),
        //             ),
        //             SizedBox(width: 8),
        //             Icon(Icons.chevron_right, color: Color(0xff9F5A5B)),
        //           ],
        //         ),
        //       ),
        //       SizedBox(height: 8),
        //       Container(
        //         padding: EdgeInsets.all(16),
        //         decoration: BoxDecoration(
        //           border: Border.all(
        //             width: 1.w,
        //             color: Color(0xff151515).withValues(alpha: 0.41),
        //           ),
        //           color: Color(0xff151515).withValues(alpha: 0.40),
        //           borderRadius: BorderRadius.circular(10.r),
        //         ),
        //         child: Row(
        //           children: [
        //             Icon(Icons.camera_alt, color: Colors.white),
        //             SizedBox(width: 8),
        //             Expanded(
        //               child: Text(
        //                 'انستجرام',
        //                 textAlign: TextAlign.start,
        //                 style: TextStyle(color: Colors.white, fontSize: 16),
        //               ),
        //             ),
        //             SizedBox(width: 8),
        //             Icon(Icons.chevron_right, color: Color(0xff9F5A5B)),
        //           ],
        //         ),
        //       ),
        //       SizedBox(height: 8),
        //       Container(
        //         padding: EdgeInsets.all(16),
        //         decoration: BoxDecoration(
        //           border: Border.all(
        //             width: 1.w,
        //             color: Color(0xff151515).withValues(alpha: 0.41),
        //           ),
        //           color: Color(0xff151515).withValues(alpha: 0.40),
        //           borderRadius: BorderRadius.circular(10.r),
        //         ),
        //         child: Row(
        //           children: [
        //             Icon(Icons.whatshot, color: Colors.white),
        //             SizedBox(width: 8),
        //             Expanded(
        //               child: Text(
        //                 'واتساب',
        //                 textAlign: TextAlign.start,
        //                 style: TextStyle(color: Colors.white, fontSize: 16),
        //               ),
        //             ),
        //             SizedBox(width: 8),
        //             Icon(Icons.chevron_right, color: Color(0xff9F5A5B)),
        //           ],
        //         ),
        //       ),
            // ],
          // ),
        // ),
        ],
      ),
    );
  }

  Widget _buildSubscriptionCard(BuildContext context, SubscriptionModel subscription) {
    final iconPath = _getIconPath(subscription.subscriptionIconType ?? 'bronze');
    
    // Calculate discount percentage
    int? discountPercentage;
    if (subscription.discountAmount != null && subscription.price != null && subscription.price! > 0) {
      if (subscription.discountType == 'percentage') {
        // If discount type is percentage, use discount_amount directly
        discountPercentage = subscription.discountAmount!.toInt();
      } else if (subscription.discountType == 'amount') {
        // If discount type is amount, calculate percentage
        discountPercentage = ((subscription.discountAmount! / subscription.price!) * 100).toInt();
      }
    }
    
    final durationText = _getDurationText(subscription.typeAmount ?? 0, subscription.typeLabel ?? '');

    return Container(
      padding: EdgeInsets.all(12.sp),
      width: 270.w,
      decoration: BoxDecoration(
        color: Color(0xFF02040B),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                  border: Border.all(
                    color: const Color(0xff151515).withValues(alpha: 0.41),
                    width: 1.w,
                  ),
                  color: Color(0xff9F5A5B).withValues(alpha: 0.10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Image.asset(
                    iconPath,
                    height: 30.h,
                    width: 30.w,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              if (discountPercentage != null)
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.r),
                    border: Border.all(
                      color: const Color(0xff9F5A5B),
                      width: 0.5.w,
                    ),
                    color: Color(0xff9F5A5B),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 4.w,
                      vertical: 2.h,
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/svgs/100.svg',
                          width: 12.w,
                          height: 14.h,
                        ),
                        4.horizontalSpace,
                        Text(
                          "$discountPercentage%",
                          style: Styles.captionSemiBold.copyWith(
                            color: Colors.white,
                            fontFamily: GoogleFonts.cairo().fontFamily,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          10.verticalSpace,
          Text(
            subscription.title ?? '',
            style: Styles.contentRegular.copyWith(
              color: Colors.white,
              fontSize: 14.sp,
              fontFamily: GoogleFonts.cairo().fontFamily,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            durationText,
            style: Styles.contentRegular.copyWith(
              color: Colors.white,
              fontSize: 12.sp,
              fontFamily: GoogleFonts.cairo().fontFamily,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (subscription.priceAfterDiscount != null &&
                      subscription.priceAfterDiscount != subscription.price) ...[
                    Text(
                      '${subscription.price?.toInt() ?? 0}',
                      style: Styles.contentRegular.copyWith(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 14.sp,
                        decoration: TextDecoration.lineThrough,
                        fontFamily: GoogleFonts.cairo().fontFamily,
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/svgs/ryal.svg',
                      width: 12.w,
                      height: 12.h,
                      fit: BoxFit.scaleDown,
                      colorFilter: ColorFilter.mode(
                        Colors.white.withOpacity(0.5),
                        BlendMode.srcIn,
                      ),
                    ),
                    4.horizontalSpace,
                  ],
                  Text(
                    '${subscription.priceAfterDiscount?.toInt() ?? subscription.price?.toInt() ?? 0}',
                    style: Styles.contentRegular.copyWith(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontFamily: GoogleFonts.cairo().fontFamily,
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/svgs/ryal.svg',
                    width: 12.w,
                    height: 12.h,
                    fit: BoxFit.scaleDown,
                  ),
                ],
              ),
              BlocBuilder<PackagesCubit, PackagesState>(
                buildWhen: (previous, current) =>
                    current is PackagesSubscribeLoading ||
                    current is PackagesSubscribeSuccess ||
                    current is PackagesSubscribeFailure,
                builder: (context, state) {
                  final isLoading = state is PackagesSubscribeLoading &&
                      context.read<PackagesCubit>().subscribingSubscriptionId == subscription.id;
                  return CustomButtonWidget(
                    text: isLoading ? 'subscribing'.tr() : 'subscribeNow'.tr(),
                    textStyle: Styles.captionBold.copyWith(
                      color: Colors.white,
                      fontFamily: GoogleFonts.cairo().fontFamily,
                    ),
                    borderRadius: 3.r,
                    width: 100.w,
                    height: 30.h,
                    color: Color(0xff4A7DFF),
                    onPressed: isLoading
                        ? null
                        : () {
                            context.read<PackagesCubit>().subscribe(
                                  subscriptionId: subscription.id ?? 0,
                                );
                          },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getIconPath(String iconType) {
    switch (iconType.toLowerCase()) {
      case 'gold':
      case 'golden':
        return 'assets/pngs/diamond.png';
      case 'silver':
        return 'assets/pngs/diamond2.png';
      case 'bronze':
      default:
        return 'assets/pngs/offer.png';
    }
  }

  String _getDurationText(int amount, String label) {
    if (amount == 0) return '';
    return '$amount $label';
  }
}
