import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:non_stop/core/constants/app_styles.dart';
import 'package:non_stop/features/home/bloc/cubit/home_cubit.dart';
import 'package:non_stop/features/profile/bloc/cubit/profile_cubit.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderOnProfileWidget extends StatelessWidget {
  const CalenderOnProfileWidget({super.key, required this.profileCubit});

  final ProfileCubit profileCubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      buildWhen: (previous, current) => current is BookChangeDateOnProfileState,
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        final previousMonth = DateTime(
                          profileCubit.focusedDay.year,
                          profileCubit.focusedDay.month - 1,
                        );
                        profileCubit.updateFocusedDay(previousMonth);
                      },
                      child: Container(
                        width: 36.w,
                        height: 36.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF9F5A5B),
                        ),
                        child: Icon(
                          Icons.chevron_left,
                          color: Colors.white,
                          size: 24.sp,
                        ),
                      ),
                    ),

                    Text(
                      DateFormat.yMMMM('ar').format(profileCubit.focusedDay),
                      style: Styles.highlightEmphasis.copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        final nextMonth = DateTime(
                          profileCubit.focusedDay.year,
                          profileCubit.focusedDay.month + 1,
                        );
                        profileCubit.updateFocusedDay(nextMonth);
                      },
                      child: Container(
                        width: 36.w,
                        height: 36.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF9F5A5B).withOpacity(0.8),
                        ),
                        child: Icon(
                          Icons.chevron_right,
                          color: Colors.white,
                          size: 24.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.schedule,
                      color: const Color(0xFFE57373),
                      size: 20.sp,
                    ),
                    8.horizontalSpace,
                    Text(
                      'اضغط على اليوم لمعرفة الوقت المتاح',
                      style: Styles.captionEmphasis.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              16.verticalSpace,

              TableCalendar(
                daysOfWeekVisible: true,
                focusedDay: profileCubit.focusedDay,
                firstDay: DateTime.now(),
                lastDay: profileCubit.endDate,
                currentDay: DateTime.now(),
                calendarFormat: CalendarFormat.month,
                locale: 'ar',
                onDaySelected: (selectedDay, focusedDay) {
                  profileCubit.chooseBookingDate(selectedDay);
                  profileCubit.updateFocusedDay(selectedDay);
                },
                onPageChanged: profileCubit.updateFocusedDay,
                selectedDayPredicate: (day) =>
                    isSameDay(day, profileCubit.selectedDate),
                daysOfWeekHeight: 32.sp,
                rowHeight: 48.sp,
                headerVisible: false,
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF9F5A5B).withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  selectedDecoration: const BoxDecoration(
                    color: Color(0xFF9F5A5B),
                    shape: BoxShape.circle,
                  ),
                  todayTextStyle: Styles.captionEmphasis.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                  selectedTextStyle: Styles.captionEmphasis.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 16.sp,
                  ),
                  disabledTextStyle: Styles.captionEmphasis.copyWith(
                    color: const Color(0xFF4A4A4A),
                  ),
                  weekendTextStyle: Styles.captionEmphasis.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                  defaultTextStyle: Styles.captionEmphasis.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                  outsideTextStyle: Styles.captionEmphasis.copyWith(
                    color: const Color(0xFF4A4A4A),
                  ),
                ),
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: Styles.captionEmphasis.copyWith(
                    color: Colors.white70,
                    fontSize: 13.sp,
                  ),
                  weekendStyle: Styles.captionEmphasis.copyWith(
                    color: Colors.white70,
                    fontSize: 13.sp,
                  ),
                ),
              ),
              16.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.sp),
                child: Divider(color: Colors.white, thickness: 1.sp),
              ),
            ],
          ),
        );
      },
    );
  }
}
