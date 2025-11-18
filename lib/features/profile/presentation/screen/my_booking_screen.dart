import 'dart:math' as math;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:non_stop/common/extensions/build_context_extensions.dart';
import 'package:non_stop/core/constants/app_colors.dart';
import 'package:non_stop/core/constants/hex_colors.dart';
import 'package:non_stop/features/profile/bloc/cubit/profile_cubit.dart';
import 'package:non_stop/features/profile/data/models/booking_response.dart';

import '../../../../core/theme/text_colors.dart';

class MyBookingScreen extends StatefulWidget {
  const MyBookingScreen({super.key});

  @override
  State<MyBookingScreen> createState() => _MyBookingScreenState();
}

class _MyBookingScreenState extends State<MyBookingScreen> {
  bool isActive = true; // true = active, false = finished

  @override
  void initState() {
    super.initState();
    // Fetch bookings when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final profileCubit = context.read<ProfileCubit>();
      profileCubit.fetchUserBookings(isActive ? 'active' : 'finished');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff160618),
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
                          angle: context.locale.languageCode == 'en' ? math.pi : 0,
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
                      'myBookings'.tr(),
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
                  child: SingleChildScrollView(
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
                                  context.read<ProfileCubit>().fetchUserBookings('active');
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
                                  context.read<ProfileCubit>().fetchUserBookings('finished');
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
                        BlocBuilder<ProfileCubit, ProfileState>(
                          buildWhen: (previous, current) =>
                              current is ProfileBookingsLoading ||
                              current is ProfileBookingsSuccess ||
                              current is ProfileBookingsFailure,
                          builder: (context, state) {
                            if (state is ProfileBookingsLoading) {
                              return Column(
                                children: [
                                  _buildSkeletonBookingCard(),
                                  18.verticalSpace,
                                  _buildSkeletonBookingCard(),
                                  18.verticalSpace,
                                  _buildSkeletonBookingCard(),
                                ],
                              );
                            }

                            if (state is ProfileBookingsFailure) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      state.message,
                                      style: Styles.featureSemiBold.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                    16.verticalSpace,
                                    ElevatedButton(
                                      onPressed: () {
                                        context.read<ProfileCubit>().fetchUserBookings(
                                            isActive ? 'active' : 'finished');
                                      },
                                      child: Text('retry'.tr()),
                                    ),
                                  ],
                                ),
                              );
                            }

                            final cubit = context.read<ProfileCubit>();
                            final bookings = cubit.bookings;

                            if (bookings.isEmpty) {
                              return Center(
                                child: Text(
                                  'noBooking'.tr(),
                                  style: Styles.featureSemiBold.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            }

                            return AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              child: Column(
                                key: ValueKey(isActive),
                                children: [
                                  ...bookings.map((booking) => Padding(
                                        padding: EdgeInsets.only(bottom: 18.h),
                                        child: _buildBookingCard(booking),
                                      )),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBookingCard(BookingModel booking) {
    final bookingDate = booking.bookingDate;
    
    return Container(
      padding: EdgeInsets.all(20.w),
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
              Text(
                'date'.tr(),
                style: Styles.featureSemiBold.copyWith(
                  color: AppColors.neutralColor100,
                ),
              ),
              Text(
                bookingDate?.date ?? '',
                style: Styles.featureStandard.copyWith(
                  color: AppColors.neutralColor500,
                ),
              ),
            ],
          ),
          12.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'time'.tr(),
                style: Styles.featureSemiBold.copyWith(
                  color: AppColors.neutralColor100,
                ),
              ),
              Text(
                bookingDate?.time ?? '',
                style: Styles.featureStandard.copyWith(
                  color: AppColors.neutralColor500,
                ),
              ),
            ],
          ),
          // if (booking.bookedAt != null) ...[
          //   12.verticalSpace,
          //   Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text(
          //         'bookedAt'.tr(),
          //         style: Styles.featureSemiBold.copyWith(
          //           color: AppColors.neutralColor100,
          //         ),
          //       ),
          //       Text(
          //         booking.bookedAt!,
          //         style: Styles.featureStandard.copyWith(
          //           color: AppColors.neutralColor500,
          //           fontSize: 12.sp,
          //         ),
          //       ),
          //     ],
          //   ),
          // ],
        ],
      ),
    );
  }

  Widget _buildSkeletonBookingCard() {
    return _ShimmerWrapper(
      child: Container(
        padding: EdgeInsets.all(20.w),
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
                  width: 60.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                Container(
                  width: 100.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ],
            ),
            12.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 60.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                Container(
                  width: 80.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ],
            ),
            12.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 80.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                Container(
                  width: 120.w,
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
      ),
    );
  }
}

class _ShimmerWrapper extends StatefulWidget {
  const _ShimmerWrapper({required this.child});

  final Widget child;

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
