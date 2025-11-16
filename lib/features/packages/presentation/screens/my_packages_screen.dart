import 'dart:math' as math;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:non_stop/common/extensions/build_context_extensions.dart';
import 'package:non_stop/core/constants/app_colors.dart';
import 'package:non_stop/core/constants/app_styles.dart';
import 'package:non_stop/core/constants/hex_colors.dart';
import 'package:non_stop/core/widgets/button/custom_button_widget.dart';
import 'package:non_stop/core/widgets/row/custom_row_with_check_widget.dart';
import 'package:non_stop/features/packages/bloc/cubit/packages_cubit.dart';
import 'package:non_stop/features/packages/data/models/user_subscription_response.dart';
import 'package:non_stop/features/packages/presentation/screens/packages_screen.dart';

class MyPackagesScreen extends StatefulWidget {
  const MyPackagesScreen({super.key});

  @override
  State<MyPackagesScreen> createState() => _MyPackagesScreenState();
}

class _MyPackagesScreenState extends State<MyPackagesScreen> {
  bool isActive = true; // true = جارية (is_expired = false), false = منتهية (is_expired = true)

  @override
  void initState() {
    super.initState();
    // Fetch user subscriptions when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PackagesCubit>().fetchUserSubscriptions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xff160618),
            const Color(0xff160618),
            const Color(0xff160618).withAlpha(20),
            const Color(0xff160618).withAlpha(20),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
            child: Column(
              children: [
                /// ===== Header =====
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        context.pop();
                      },
                      child: Container(
                        width: 44.w,
                        height: 44.h,
                        decoration: BoxDecoration(
                          color: const Color(0xff2A1A2C),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Transform.rotate(
                          angle: context.locale.languageCode == 'en' ? math.pi : 0, // 180 degrees (π radians) for English
                          child: SvgPicture.asset(
                            "assets/svgs/Back _con.svg",
                            width: 24.w,
                            height: 24.h,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'myPackages'.tr(),
                      style: Styles.heading2.copyWith(color: Colors.white),
                    ),
                    Container(
                      width: 44.w,
                      height: 44.h,
                      decoration: BoxDecoration(
                        color: const Color(0xff2A1A2C),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: SvgPicture.asset(
                        "assets/svgs/Notification.svg",
                        width: 24.w,
                        height: 24.h,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ],
                ),

                /// ===== Body =====
                Expanded(
                  child: Column(
                    children: [
                      42.verticalSpace,

                      /// ===== Toggle Buttons =====
                      Row(
                        spacing: 8.w,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // ---- جارية ----
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() => isActive = true);
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                padding: EdgeInsets.symmetric(vertical: 13.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: isActive
                                      ? hexToColor('#9F5A5B')
                                      : hexToColor('#02040B'),
                                  border: Border.all(
                                    color: isActive
                                        ? hexToColor('#B98B8C')
                                        : Colors.transparent,
                                    width: 1.w,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'active'.tr(),
                                    style: Styles.featureEmphasis.copyWith(
                                      color: isActive
                                          ? AppColors.neutralColor100
                                          : AppColors.neutralColor500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // ---- منتهية ----
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() => isActive = false);
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                padding: EdgeInsets.symmetric(vertical: 13.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: !isActive
                                      ? hexToColor('#9F5A5B')
                                      : hexToColor('#02040B'),
                                  border: Border.all(
                                    color: !isActive
                                        ? hexToColor('#B98B8C')
                                        : Colors.transparent,
                                    width: 1.w,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'completed'.tr(),
                                    style: Styles.featureEmphasis.copyWith(
                                      color: !isActive
                                          ? AppColors.neutralColor100
                                          : AppColors.neutralColor500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      34.verticalSpace,
                      Expanded(
                        child: BlocBuilder<PackagesCubit, PackagesState>(
                          buildWhen: (previous, current) =>
                              current is PackagesUserSubscriptionsLoading ||
                              current is PackagesUserSubscriptionsSuccess ||
                              current is PackagesUserSubscriptionsFailure,
                          builder: (context, state) {
                            if (state is PackagesUserSubscriptionsLoading) {
                              return SingleChildScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    _buildSkeletonSubscriptionCard(),
                                    18.verticalSpace,
                                    _buildSkeletonSubscriptionCard(),
                                    18.verticalSpace,
                                    _buildSkeletonSubscriptionCard(),
                                  ],
                                ),
                              );
                            }

                            if (state is PackagesUserSubscriptionsFailure) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      state.message,
                                      style: Styles.featureSemibold.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                    16.verticalSpace,
                                    ElevatedButton(
                                      onPressed: () {
                                        context.read<PackagesCubit>().fetchUserSubscriptions();
                                      },
                                      child: Text('retry'.tr()),
                                    ),
                                  ],
                                ),
                              );
                            }

                            final cubit = context.read<PackagesCubit>();
                            final allSubscriptions = cubit.userSubscriptions;

                            // Filter subscriptions based on is_expired
                            final filteredSubscriptions = allSubscriptions.where((sub) {
                              if (isActive) {
                                // Show active subscriptions (is_expired == false)
                                return sub.isExpired == false;
                              } else {
                                // Show completed subscriptions (is_expired == true)
                                return sub.isExpired == true;
                              }
                            }).toList();

                            if (filteredSubscriptions.isEmpty) {
                              return Center(
                                child: Text(
                                  isActive ? 'noActivePackages'.tr() : 'noCompletedPackages'.tr(),
                                  style: Styles.featureSemibold.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            }

                            return SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                child: Column(
                                  key: ValueKey(isActive),
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ...filteredSubscriptions.map((subscription) => Padding(
                                          padding: EdgeInsets.only(bottom: 18.h),
                                          child: _buildSubscriptionCard(subscription),
                                        )),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                if (isActive)
                  CustomButtonWidget(
                    color: hexToColor('#9F5A5B'),
                    text: 'اشتراك في باقة جديدة',
                    textStyle: Styles.highlightBold.copyWith(
                      color: AppColors.neutralColor100,
                    ),
                    onPressed: () async {
                      await context.push(
                        MaterialPageRoute(
                          builder: (context) => const PackagesScreen(),
                        ),
                      );
                      // Refresh user subscriptions when returning from packages screen
                      if (mounted) {
                        context.read<PackagesCubit>().fetchUserSubscriptions();
                      }
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubscriptionCard(UserSubscriptionModel subscription) {
    final subscriptionDetail = subscription.subscription;
    if (subscriptionDetail == null) {
      return const SizedBox.shrink();
    }

    final iconPath = _getIconPath(subscriptionDetail.subscriptionIconType ?? 'bronze');
    final benefits = subscriptionDetail.benefits?.split('\n').where((b) => b.trim().isNotEmpty).toList() ?? [];
    final durationText = _getDurationText(
      subscriptionDetail.typeAmount ?? 0,
      subscriptionDetail.typeLabel ?? '',
    );

    return Container(
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 36.h,
        bottom: 24.h,
      ),
      decoration: BoxDecoration(
        color: hexToColor('#02040B'),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: Color(0xff15151569).withValues(alpha: .5),
          width: .5.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(8.sp),
                decoration: BoxDecoration(
                  color: Color(0xff9f5a5b1a).withAlpha(10),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Image.asset(
                  iconPath,
                  width: 26.w,
                  height: 26.h,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Show original price with strikethrough if there's a discount
                  if ((subscription.originalPrice != null && 
                       subscription.paidAmount != null && 
                       subscription.originalPrice! > subscription.paidAmount!) ||
                      (subscriptionDetail.price != null && 
                       subscriptionDetail.priceAfterDiscount != null && 
                       subscriptionDetail.price! > subscriptionDetail.priceAfterDiscount!))
                    ...[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${subscription.originalPrice?.toInt() ?? subscriptionDetail.price?.toInt() ?? 0}',
                            style: Styles.heading3.copyWith(
                              color: AppColors.neutralColor100.withOpacity(0.5),
                              decoration: TextDecoration.lineThrough,
                              decorationColor: AppColors.neutralColor100,
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          SvgPicture.asset(
                            'assets/svgs/ryal.svg',
                            width: 14.w,
                            height: 14.h,
                            fit: BoxFit.scaleDown,
                            colorFilter: ColorFilter.mode(
                              AppColors.neutralColor100.withOpacity(0.5),
                              BlendMode.srcIn,
                            ),
                          ),
                          SizedBox(width: 8.w),
                        ],
                      ),
                    ],
                  // Show discounted/paid price
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${subscription.paidAmount?.toInt() ?? subscriptionDetail.priceAfterDiscount?.toInt() ?? 0}',
                        style: Styles.display3.copyWith(
                          color: AppColors.neutralColor100,
                        ),
                      ),
                      SvgPicture.asset(
                        'assets/svgs/ryal.svg',
                        fit: BoxFit.scaleDown,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          8.verticalSpace,
          Text(
            subscriptionDetail.title ?? '',
            style: Styles.featureSemibold.copyWith(
              color: AppColors.neutralColor100,
            ),
          ),
          if (subscription.startDate != null || subscription.endDate != null) ...[
            8.verticalSpace,
            Row(
              children: [
                if (subscription.startDate != null)
                  Text(
                    '${'startDate'.tr()}: ${subscription.startDate}',
                    style: Styles.featureStandard.copyWith(
                      color: AppColors.neutralColor500,
                      fontSize: 12.sp,
                    ),
                  ),
                if (subscription.startDate != null && subscription.endDate != null)
                  Text(
                    ' | ',
                    style: Styles.featureStandard.copyWith(
                      color: AppColors.neutralColor500,
                      fontSize: 12.sp,
                    ),
                  ),
                if (subscription.endDate != null)
                  Text(
                    '${'endDate'.tr()}: ${subscription.endDate}',
                    style: Styles.featureStandard.copyWith(
                      color: AppColors.neutralColor500,
                      fontSize: 12.sp,
                    ),
                  ),
              ],
            ),
          ],
          16.verticalSpace,
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(5.r),
                    border: Border.all(
                      color: Color(0xFF9F5A5B).withValues(alpha: .5),
                      width: .5.w,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      durationText,
                      style: Styles.featureSemibold.copyWith(
                        color: hexToColor('#9F5A5B'),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (benefits.isNotEmpty) ...[
            19.verticalSpace,
            Text(
              'features'.tr(),
              style: Styles.featureSemibold.copyWith(
                color: AppColors.neutralColor100,
              ),
            ),
            21.verticalSpace,
            ...benefits.map((benefit) => Padding(
                  padding: EdgeInsets.only(bottom: 6.h),
                  child: CustomRowWithCheckWidget(
                    text: benefit.trim(),
                  ),
                )),
          ],
        ],
      ),
    );
  }

  String _getIconPath(String iconType) {
    switch (iconType.toLowerCase()) {
      case 'bronze':
        return 'assets/pngs/diamond2.png';
      case 'gold':
      case 'silver':
      default:
        return 'assets/pngs/diamond.png';
    }
  }

  String _getDurationText(int amount, String typeLabel) {
    if (amount > 0 && typeLabel.isNotEmpty) {
      return '$amount $typeLabel';
    }
    return typeLabel.isNotEmpty ? typeLabel : '';
  }

  Widget _buildSkeletonSubscriptionCard() {
    return _ShimmerWrapper(
      child: Container(
        padding: EdgeInsets.only(
          left: 20.w,
          right: 20.w,
          top: 36.h,
          bottom: 24.h,
        ),
        decoration: BoxDecoration(
          color: hexToColor('#02040B'),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: Color(0xFF15151569).withValues(alpha: .5),
            width: .5.w,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(8.sp),
                  decoration: BoxDecoration(
                    color: Color(0xFF9F5A5B1A).withAlpha(10),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Container(
                    width: 26.w,
                    height: 26.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 60.w,
                      height: 24.h,
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                    8.horizontalSpace,
                    Container(
                      width: 20.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            8.verticalSpace,
            Container(
              width: 150.w,
              height: 20.h,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            16.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(5.r),
                      border: Border.all(
                        color: Color(0xFF9F5A5B).withValues(alpha: .5),
                        width: .5.w,
                      ),
                    ),
                    child: Center(
                      child: Container(
                        width: 80.w,
                        height: 16.h,
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            19.verticalSpace,
            Container(
              width: 80.w,
              height: 18.h,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            21.verticalSpace,
            Container(
              width: double.infinity,
              height: 16.h,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            6.verticalSpace,
            Container(
              width: double.infinity,
              height: 16.h,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            6.verticalSpace,
            Container(
              width: 200.w,
              height: 16.h,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShimmerWrapper extends StatefulWidget {
  final Widget child;

  const _ShimmerWrapper({required this.child});

  @override
  State<_ShimmerWrapper> createState() => _ShimmerWrapperState();
}

class _ShimmerWrapperState extends State<_ShimmerWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment(-1.0 - _controller.value * 2, 0.0),
              end: Alignment(1.0 - _controller.value * 2, 0.0),
              colors: [
                Colors.grey[800]!,
                Colors.grey[700]!,
                Colors.grey[800]!,
              ],
              stops: const [0.0, 0.5, 1.0],
            ).createShader(bounds);
          },
          child: widget.child,
        );
      },
    );
  }
}