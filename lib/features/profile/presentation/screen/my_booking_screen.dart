import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:non_stop/common/extensions/build_context_extensions.dart';
import 'package:non_stop/core/constants/app_colors.dart';
import 'package:non_stop/core/constants/hex_colors.dart';
import 'package:non_stop/features/home/presentation/widgets/time_slots_widget.dart';
import 'package:non_stop/features/profile/bloc/cubit/profile_cubit.dart';
import 'package:non_stop/features/profile/presentation/widgets/calender_widget.dart';

import '../../../../core/theme/text_colors.dart';

class MyBookingScreen extends StatefulWidget {
  const MyBookingScreen({super.key});

  @override
  State<MyBookingScreen> createState() => _MyBookingScreenState();
}

class _MyBookingScreenState extends State<MyBookingScreen> {
  bool isActive = true; // true = جارية, false = منتهية
  int selectedTab = 0;

  DateTime selectedDate = DateTime.now();

  int selectedDay = 4;

  String? selectedTimeSlot;
  final times = [
    ['11:5', '11:6'],
    ['9:5', '10'],
    ['7:5', '8'],
    ['5:5', '6'],
    ['3:5', '4'],
    ['1:5', '2'],
    // ['11:5', '12'],
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff160618),

        // gradient: LinearGradient(
        //   begin: Alignment.topCenter,
        //   end: Alignment.bottomCenter,
        //   colors: [
        //     const Color(0xff160618),
        //     const Color(0xff160618),
        //     const Color(0xff160618).withAlpha(20),
        //     const Color(0xff160618).withAlpha(20),
        //   ],
        // ),
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
                        child: SvgPicture.asset(
                          "assets/svgs/Back _con.svg",
                          width: 24.w,
                          height: 24.h,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                    Text(
                      'حجوزاتي',
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
                                      'جارية',
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
                                      'منتهية',
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

                        /// Example: يمكن هنا بعدين تضيف محتوى الباقات بناءً على الحالة
                        34.verticalSpace,
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: isActive
                              ? CustomActiveBodyOnMyBookingWidget(times: times)
                              : CustomActiveBodyOnMyBookingWidget(times: times),
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
}

class CustomActiveBodyOnMyBookingWidget extends StatelessWidget {
  const CustomActiveBodyOnMyBookingWidget({
    super.key,
    required this.times,
    this.selectedTimeSlot,
  });

  final List<List<String>> times;
  final String? selectedTimeSlot;

  @override
  Widget build(BuildContext context) {
    final profileCubit = BlocProvider.of<ProfileCubit>(context);

    return Column(
      children: [
        CalenderOnProfileWidget(profileCubit: profileCubit),

        TimeSlotsWidget(times: times, selectedTimeSlot: selectedTimeSlot),
      ],
    );
  }
}
