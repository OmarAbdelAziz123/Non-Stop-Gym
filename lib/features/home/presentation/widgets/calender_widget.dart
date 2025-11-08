import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:non_stop/core/constants/app_colors.dart';
import 'package:non_stop/core/constants/app_styles.dart';
import 'package:non_stop/features/home/bloc/cubit/home_cubit.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderWidget extends StatelessWidget {
  const CalenderWidget({super.key, required this.homeCubit});

  final HomeCubit homeCubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) => current is BookChangeDateState,
      builder: (context, state) {
        return Container(
          color: Colors.black.withOpacity(0.42),
          child: Column(
            children: [
              TableCalendar(
                daysOfWeekVisible: true,
                focusedDay: homeCubit.focusedDay,
                firstDay: DateTime.now(),
                lastDay: homeCubit.endDate,
                currentDay: DateTime.now(),
                calendarFormat: CalendarFormat.month,
                locale: 'ar', // Force Arabic locale for Arabic month/day names
                onDaySelected: (selectedDay, focusedDay) {
                  homeCubit.chooseBookingDate(selectedDay);
                  homeCubit.updateFocusedDay(selectedDay);
                },
                onPageChanged: homeCubit.updateFocusedDay,
                selectedDayPredicate: (day) =>
                    isSameDay(day, homeCubit.selectedDate),
                daysOfWeekHeight: 28.sp,
                calendarStyle: CalendarStyle(
                  todayDecoration: const BoxDecoration(shape: BoxShape.circle),
                  selectedDecoration: BoxDecoration(
                    color: const Color(0xff9F5A5B),
                    shape: BoxShape.circle,
                  ),
                  todayTextStyle: Styles.captionEmphasis.copyWith(
                    color: AppColors.neutralColor900,
                  ),
                  selectedTextStyle: Styles.captionEmphasis.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  // 👇 Dark grey for disabled days
                  disabledTextStyle: Styles.captionEmphasis.copyWith(
                    color: Colors.grey.shade700,
                  ),
                  // Optional: make weekends slightly faded
                  weekendTextStyle: Styles.captionEmphasis.copyWith(
                    color: Colors.white70,
                  ),
                  defaultTextStyle: Styles.captionEmphasis.copyWith(
                    color: Colors.white,
                  ),
                ),
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  leftChevronIcon: Container(
                    padding: EdgeInsets.all(6.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: AppColors.primaryColor900),
                      color: Colors.white,
                    ),
                    child: Icon(
                      Icons.chevron_left,
                      size: 18.sp,
                      color: Colors.black,
                    ),
                  ),
                  rightChevronIcon: Container(
                    padding: EdgeInsets.all(6.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: AppColors.primaryColor900),
                      color: Colors.white,
                    ),
                    child: Icon(
                      Icons.chevron_right,
                      size: 18.sp,
                      color: Colors.black,
                    ),
                  ),
                  titleTextStyle: Styles.highlightEmphasis.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor900,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: AppColors.primaryColor900,
                        width: 1.sp,
                      ),
                    ),
                  ),
                  // 👇 Format month name in Arabic
                  titleTextFormatter: (date, locale) =>
                      DateFormat.yMMMM('ar').format(date),
                ),
              ),
              16.verticalSpace,
              Divider(color: AppColors.neutralColor300, thickness: 1),
            ],
          ),
        );
      },
    );
  }
}
