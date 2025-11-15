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
import 'package:non_stop/features/main%20layout/business_logic/main_layout_cubit.dart';
import 'package:non_stop/features/packages/bloc/cubit/packages_cubit.dart';
import 'package:non_stop/features/packages/data/models/subscription_response.dart';

class PackagesScreen extends StatelessWidget {
  const PackagesScreen({super.key});

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
                        context.read<MainLayoutCubit>().changeBottomNavBar(0);
                      },
                      child: Container(
                        width: 44.w,
                        height: 44.h,
                        decoration: BoxDecoration(
                          color: const Color(0xff2A1A2C),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: SvgPicture.asset(
                          "assets/svgs/Back _con.svg",
                          width: 24.w,
                          height: 24.h,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                    Text(
                      'الباقات',
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
                  child: BlocBuilder<PackagesCubit, PackagesState>(
                    builder: (context, state) {
                      if (state is PackagesLoading) {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              42.verticalSpace,
                              _buildSkeletonSubscriptionCard(),
                              18.verticalSpace,
                              _buildSkeletonSubscriptionCard(),
                              18.verticalSpace,
                              _buildSkeletonSubscriptionCard(),
                            ],
                          ),
                        );
                      }

                      if (state is PackagesFailure) {
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
                                  context.read<PackagesCubit>().fetchSubscriptions();
                                },
                                child: const Text('إعادة المحاولة'),
                              ),
                            ],
                          ),
                        );
                      }

                      final subscriptions = state is PackagesSuccess
                          ? state.subscriptions
                          : <SubscriptionModel>[];

                      if (subscriptions.isEmpty) {
                        return Center(
                          child: Text(
                            'لا توجد باقات متاحة',
                            style: Styles.featureSemibold.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        );
                      }

                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            42.verticalSpace,
                            ...subscriptions.map((subscription) => Padding(
                                  padding: EdgeInsets.only(bottom: 18.h),
                                  child: _buildSubscriptionCard(context, subscription),
                                )),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubscriptionCard(BuildContext context, SubscriptionModel subscription) {
    final iconPath = _getIconPath(subscription.subscriptionIconType ?? 'bronze');
    final benefits = subscription.benefits?.split('\n') ?? [];
    final durationText = _getDurationText(subscription.typeAmount ?? 0, subscription.typeLabel ?? '');

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
                  if (subscription.priceAfterDiscount != null &&
                      subscription.priceAfterDiscount != subscription.price) ...[
                    // Original price with strikethrough
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${subscription.price?.toInt() ?? 0}',
                          style: Styles.heading3.copyWith(
                            color: AppColors.neutralColor100.withOpacity(0.5),
                            decoration: TextDecoration.lineThrough,
                            decorationColor: AppColors.neutralColor100,
                          ),
                        ),
                        SvgPicture.asset(
                          'assets/svgs/ryal.svg',
                          width: 16.w,
                          height: 16.h,
                          fit: BoxFit.scaleDown,
                          colorFilter: ColorFilter.mode(
                            AppColors.neutralColor100.withOpacity(0.5),
                            BlendMode.srcIn,
                          ),
                        ),
                        8.horizontalSpace,
                      ],
                    ),
                  ],
                  // Discounted price or original price
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${subscription.priceAfterDiscount?.toInt() ?? subscription.price?.toInt() ?? 0}',
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
            subscription.title ?? '',
            style: Styles.featureSemibold.copyWith(
              color: AppColors.neutralColor100,
            ),
          ),
          16.verticalSpace,
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 20.w,
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 10.h,
                  ),
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
              'المميزات',
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
          30.verticalSpace,
          CustomButtonWidget(
            onPressed: () {},
            text: 'اشتراك الان',
            textStyle: Styles.highlightBold.copyWith(
              color: AppColors.neutralColor100,
            ),
            color: const Color(0xFF9F5A5B),
            height: 56.h,
          ),
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
                    margin: EdgeInsets.symmetric(
                      horizontal: 20.w,
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 10.h,
                    ),
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
            30.verticalSpace,
            Container(
              width: double.infinity,
              height: 56.h,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(8.r),
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
