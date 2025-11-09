import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:non_stop/core/constants/app_styles.dart';

class TimeSlotsWidget extends StatelessWidget {
  const TimeSlotsWidget({
    super.key,
    required this.times,
    required this.selectedTimeSlot,
    this.onTimeSlotSelected,
  });

  final List<List<String>> times;
  final String? selectedTimeSlot;
  final Function(String)? onTimeSlotSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
                Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: const BoxDecoration(
                    color: Color(0xFFE57373),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.schedule, color: Colors.white, size: 16.sp),
                ),
                12.horizontalSpace,
                Text(
                  'الوقت المتاح',
                  style: Styles.captionEmphasis.copyWith(
                    color: Colors.white,
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),

          LayoutBuilder(
            builder: (context, constraints) {
              final cardWidth = (constraints.maxWidth - 12.w) / 2;

              return Wrap(
                spacing: 12.w,
                runSpacing: 12.h,
                alignment: WrapAlignment.center,
                children: times.map((time) {
                  final timeKey = '${time[0]}-${time[1]}';
                  final isSelected = selectedTimeSlot == timeKey;
                  return GestureDetector(
                    onTap: () {
                      onTimeSlotSelected?.call(timeKey);
                    },
                    child: Container(
                      width: cardWidth,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFFE57373)
                              : Colors.white,
                          width: 1.w,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              ' ${time[0]}صباحا',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2.w),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.keyboard_arrow_left,
                                  color: const Color(0xFFE57373),
                                  size: 17.sp,
                                ),
                                Icon(
                                  Icons.keyboard_arrow_left,
                                  color: const Color(0xFFE57373),
                                  size: 17.sp,
                                ),
                              ],
                            ),
                          ),

                          Flexible(
                            child: Text(
                              ' ${time[1]} صباحا',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
