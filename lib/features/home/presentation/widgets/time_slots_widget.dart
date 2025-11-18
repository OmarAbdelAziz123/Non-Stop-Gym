import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:non_stop/core/constants/app_styles.dart';
import 'package:non_stop/features/home/data/models/available_slots_response.dart';

class TimeSlotsWidget extends StatelessWidget {
  const TimeSlotsWidget({
    super.key,
    required this.slots,
    required this.selectedSlotId,
    this.onSlotSelected,
  });

  final List<AvailableSlotModel> slots;
  final int? selectedSlotId;
  final Function(AvailableSlotModel)? onSlotSelected;

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
                  'availableTime'.tr(),
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
                children: slots.map((slot) {
                  final isSelected = selectedSlotId == slot.id;
                  
                  return GestureDetector(
                    onTap: () {
                      onSlotSelected?.call(slot);
                    },
                    child: Container(
                      width: cardWidth,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFFE57373).withOpacity(0.2)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFFE57373)
                              : Colors.white,
                          width: isSelected ? 2.w : 1.w,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          slot.time ?? '',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                            fontFamily: GoogleFonts.cairo().fontFamily,
                          ),
                        ),
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
