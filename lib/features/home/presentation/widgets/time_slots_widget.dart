// // // // import 'package:flutter/material.dart';
// // // // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // // // import 'package:non_stop/core/constants/app_styles.dart';

// // // // class TimeSlotsWidget extends StatelessWidget {
// // // //   const TimeSlotsWidget({
// // // //     super.key,
// // // //     required this.times,
// // // //     required this.selectedTimeSlot,
// // // //   });

// // // //   final List<List<String>> times;
// // // //   final String? selectedTimeSlot;

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Padding(
// // // //       padding: const EdgeInsets.all(16),
// // // //       child: Column(
// // // //         crossAxisAlignment: CrossAxisAlignment.center,
// // // //         children: [
// // // //           Container(
// // // //             margin: EdgeInsets.symmetric(horizontal: 20.w),
// // // //             padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
// // // //             decoration: BoxDecoration(
// // // //               color: Colors.transparent,
// // // //               borderRadius: BorderRadius.circular(8.r),
// // // //             ),
// // // //             child: Row(
// // // //               mainAxisSize: MainAxisSize.min,
// // // //               children: [
// // // //                 Icon(
// // // //                   Icons.schedule,
// // // //                   color: const Color(0xFFE57373),
// // // //                   size: 20.sp,
// // // //                 ),
// // // //                 8.horizontalSpace,
// // // //                 Text(
// // // //                   'الوقت المتاح',
// // // //                   style: Styles.captionEmphasis.copyWith(color: Colors.white),
// // // //                 ),
// // // //               ],
// // // //             ),
// // // //           ),
// // // //           const SizedBox(height: 12),
// // // //           Wrap(
// // // //             spacing: 10,
// // // //             runSpacing: 8,
// // // //             children: times.map((time) {
// // // //               final timeKey = '${time[0]}-${time[1]}';
// // // //               final isSelected = selectedTimeSlot == timeKey;
// // // //               return GestureDetector(
// // // //                 onTap: () {},

// // // //                 child: Container(
// // // //                   padding: const EdgeInsets.symmetric(
// // // //                     horizontal: 16,
// // // //                     vertical: 8,
// // // //                   ),
// // // //                   decoration: BoxDecoration(
// // // //                     color: const Color(0xFF2A2535),
// // // //                     borderRadius: BorderRadius.circular(8),
// // // //                     border: Border.all(
// // // //                       color: isSelected ? Colors.white : Colors.red,
// // // //                       width: 2,
// // // //                     ),
// // // //                   ),
// // // //                   child: Row(
// // // //                     mainAxisSize: MainAxisSize.min,
// // // //                     children: [
// // // //                       Text(
// // // //                         'صباحا ${time[0]}',
// // // //                         style: const TextStyle(
// // // //                           color: Colors.white,
// // // //                           fontSize: 12,
// // // //                         ),
// // // //                       ),
// // // //                       const SizedBox(width: 8),
// // // //                       const Icon(Icons.close, color: Colors.red, size: 12),
// // // //                       const SizedBox(width: 8),
// // // //                       Text(
// // // //                         'صباحا ${time[1]}',
// // // //                         style: const TextStyle(
// // // //                           color: Colors.white,
// // // //                           fontSize: 12,
// // // //                         ),
// // // //                       ),
// // // //                     ],
// // // //                   ),
// // // //                 ),
// // // //               );
// // // //             }).toList(),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }
// // // // }
// // // import 'package:flutter/material.dart';
// // // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // // import 'package:non_stop/core/constants/app_styles.dart';

// // // class TimeSlotsWidget extends StatelessWidget {
// // //   const TimeSlotsWidget({
// // //     super.key,
// // //     required this.times,
// // //     required this.selectedTimeSlot,
// // //     this.onTimeSlotSelected,
// // //   });

// // //   final List<List<String>> times;
// // //   final String? selectedTimeSlot;
// // //   final Function(String)? onTimeSlotSelected;

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Padding(
// // //       padding: EdgeInsets.all(16.w),
// // //       child: Column(
// // //         crossAxisAlignment: CrossAxisAlignment.center,
// // //         children: [
// // //           // Header with icon
// // //           Container(
// // //             margin: EdgeInsets.symmetric(horizontal: 20.w),
// // //             padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
// // //             decoration: BoxDecoration(
// // //               color: Colors.transparent,
// // //               borderRadius: BorderRadius.circular(8.r),
// // //             ),
// // //             child: Row(
// // //               mainAxisSize: MainAxisSize.min,
// // //               children: [
// // //                 Container(
// // //                   padding: EdgeInsets.all(6.w),
// // //                   decoration: const BoxDecoration(
// // //                     color: Color(0xFFE57373),
// // //                     shape: BoxShape.circle,
// // //                   ),
// // //                   child: Icon(Icons.schedule, color: Colors.white, size: 16.sp),
// // //                 ),
// // //                 12.horizontalSpace,
// // //                 Text(
// // //                   'الوقت المتاح',
// // //                   style: Styles.captionEmphasis.copyWith(
// // //                     color: Colors.white,
// // //                     fontSize: 16.sp,
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),
// // //           ),
// // //           SizedBox(height: 20.h),
// // //           // Time slots grid
// // //           Wrap(
// // //             spacing: 12.w,
// // //             runSpacing: 12.h,
// // //             alignment: WrapAlignment.center,
// // //             children: times.map((time) {
// // //               final timeKey = '${time[0]}-${time[1]}';
// // //               final isSelected = selectedTimeSlot == timeKey;
// // //               return GestureDetector(
// // //                 onTap: () {
// // //                   onTimeSlotSelected?.call(timeKey);
// // //                 },
// // //                 child: Container(
// // //                   width: 280.w,
// // //                   padding: EdgeInsets.symmetric(
// // //                     horizontal: 20.w,
// // //                     vertical: 14.h,
// // //                   ),
// // //                   decoration: BoxDecoration(
// // //                     color: const Color(0xFF1A1625),
// // //                     borderRadius: BorderRadius.circular(12.r),
// // //                     border: Border.all(
// // //                       color: isSelected
// // //                           ? const Color(0xFFE57373)
// // //                           : const Color(0xFF2A2535),
// // //                       width: 1.5,
// // //                     ),
// // //                   ),
// // //                   child: Row(
// // //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                     children: [
// // //                       // End time
// // //                       Text(
// // //                         'صباحا ${time[1]}',
// // //                         style: TextStyle(
// // //                           color: Colors.white,
// // //                           fontSize: 16.sp,
// // //                           fontWeight: FontWeight.w500,
// // //                         ),
// // //                       ),
// // //                       // Arrow icon
// // //                       Row(
// // //                         children: [
// // //                           Icon(
// // //                             Icons.arrow_back_ios_rounded,
// // //                             color: const Color(0xFFE57373),
// // //                             size: 18.sp,
// // //                           ),
// // //                           Icon(
// // //                             Icons.arrow_back_ios_rounded,
// // //                             color: const Color(0xFFE57373),
// // //                             size: 18.sp,
// // //                           ),
// // //                         ],
// // //                       ),
// // //                       // Start time
// // //                       Text(
// // //                         'صباحا ${time[0]}',
// // //                         style: TextStyle(
// // //                           color: Colors.white,
// // //                           fontSize: 16.sp,
// // //                           fontWeight: FontWeight.w500,
// // //                         ),
// // //                       ),
// // //                     ],
// // //                   ),
// // //                 ),
// // //               );
// // //             }).toList(),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }
// // import 'package:flutter/material.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:non_stop/core/constants/app_styles.dart';

// // class TimeSlotsWidget extends StatelessWidget {
// //   const TimeSlotsWidget({
// //     super.key,
// //     required this.times,
// //     required this.selectedTimeSlot,
// //     this.onTimeSlotSelected,
// //   });

// //   final List<List<String>> times;
// //   final String? selectedTimeSlot;
// //   final Function(String)? onTimeSlotSelected;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Padding(
// //       padding: EdgeInsets.all(16.w),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.center,
// //         children: [
// //           // Header with icon
// //           Container(
// //             margin: EdgeInsets.symmetric(horizontal: 20.w),
// //             padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
// //             decoration: BoxDecoration(
// //               color: Colors.transparent,
// //               borderRadius: BorderRadius.circular(8.r),
// //             ),
// //             child: Row(
// //               mainAxisSize: MainAxisSize.min,
// //               children: [
// //                 Container(
// //                   padding: EdgeInsets.all(6.w),
// //                   decoration: const BoxDecoration(
// //                     color: Color(0xFFE57373),
// //                     shape: BoxShape.circle,
// //                   ),
// //                   child: Icon(Icons.schedule, color: Colors.white, size: 16.sp),
// //                 ),
// //                 12.horizontalSpace,
// //                 Text(
// //                   'الوقت المتاح',
// //                   style: Styles.captionEmphasis.copyWith(
// //                     color: Colors.white,
// //                     fontSize: 16.sp,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //           SizedBox(height: 20.h),
// //           // Time slots grid
// //           Wrap(
// //             spacing: 12.w,
// //             runSpacing: 12.h,
// //             alignment: WrapAlignment.center,
// //             children: times.map((time) {
// //               final timeKey = '${time[0]}-${time[1]}';
// //               final isSelected = selectedTimeSlot == timeKey;
// //               return GestureDetector(
// //                 onTap: () {
// //                   onTimeSlotSelected?.call(timeKey);
// //                 },
// //                 child: Container(
// //                   width: 165.w,
// //                   padding: EdgeInsets.symmetric(
// //                     horizontal: 16.w,
// //                     vertical: 12.h,
// //                   ),
// //                   decoration: BoxDecoration(
// //                     color: Colors.transparent,
// //                     borderRadius: BorderRadius.circular(8.r),
// //                     border: Border.all(
// //                       color: isSelected
// //                           ? Colors.white
// //                           : const Color(0xFFE57373),
// //                       width: 1.5,
// //                     ),
// //                   ),
// //                   child: Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                     children: [
// //                       // Start time (on the right in RTL)
// //                       Text(
// //                         'صباحا ${time[0]}',
// //                         style: TextStyle(
// //                           color: Colors.white,
// //                           fontSize: 14.sp,
// //                           fontWeight: FontWeight.w400,
// //                         ),
// //                       ),
// //                       // Double arrow icon
// //                       Row(
// //                         mainAxisSize: MainAxisSize.min,
// //                         children: [
// //                           Icon(
// //                             Icons.keyboard_arrow_left,
// //                             color: const Color(0xFFE57373),
// //                             size: 20.sp,
// //                           ),
// //                           Icon(
// //                             Icons.keyboard_arrow_left,
// //                             color: const Color(0xFFE57373),
// //                             size: 20.sp,
// //                           ),
// //                         ],
// //                       ),
// //                       // End time (on the left in RTL)
// //                       Text(
// //                         'صباحا ${time[1]}',
// //                         style: TextStyle(
// //                           color: Colors.white,
// //                           fontSize: 14.sp,
// //                           fontWeight: FontWeight.w400,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               );
// //             }).toList(),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:non_stop/core/constants/app_styles.dart';

// class TimeSlotsWidget extends StatelessWidget {
//   const TimeSlotsWidget({
//     super.key,
//     required this.times,
//     required this.selectedTimeSlot,
//     this.onTimeSlotSelected,
//   });

//   final List<List<String>> times;
//   final String? selectedTimeSlot;
//   final Function(String)? onTimeSlotSelected;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(16.w),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           // Header with icon
//           Container(
//             margin: EdgeInsets.symmetric(horizontal: 20.w),
//             padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
//             decoration: BoxDecoration(
//               color: Colors.transparent,
//               borderRadius: BorderRadius.circular(8.r),
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Container(
//                   padding: EdgeInsets.all(6.w),
//                   decoration: const BoxDecoration(
//                     color: Color(0xFFE57373),
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(Icons.schedule, color: Colors.white, size: 16.sp),
//                 ),
//                 12.horizontalSpace,
//                 Text(
//                   'الوقت المتاح',
//                   style: Styles.captionEmphasis.copyWith(
//                     color: Colors.white,
//                     fontSize: 16.sp,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 20.h),
//           // Time slots grid
//           LayoutBuilder(
//             builder: (context, constraints) {
//               // حساب عرض كل كارد بناءً على عرض الشاشة
//               final cardWidth = (constraints.maxWidth - 12.w) / 2;

//               return Wrap(
//                 spacing: 12.w,
//                 runSpacing: 12.h,
//                 alignment: WrapAlignment.center,
//                 children: times.map((time) {
//                   final timeKey = '${time[0]}-${time[1]}';
//                   final isSelected = selectedTimeSlot == timeKey;
//                   return GestureDetector(
//                     onTap: () {
//                       onTimeSlotSelected?.call(timeKey);
//                     },
//                     child: Container(
//                       width: cardWidth,
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 12.w,
//                         vertical: 12.h,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Colors.transparent,
//                         borderRadius: BorderRadius.circular(8.r),
//                         border: Border.all(
//                           color: isSelected
//                               ? const Color(0xFFE57373)
//                               : Colors.white,
//                           width: 1.w,
//                         ),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           // Start time (on the right in RTL)
//                           Flexible(
//                             child: Text(
//                               'صباحا ${time[0]}',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 13.sp,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                           // Double arrow icon
//                           Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 4.w),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Icon(
//                                   Icons.keyboard_arrow_left,
//                                   color: const Color(0xFFE57373),
//                                   size: 18.sp,
//                                 ),
//                                 Icon(
//                                   Icons.keyboard_arrow_left,
//                                   color: const Color(0xFFE57373),
//                                   size: 18.sp,
//                                 ),
//                               ],
//                             ),
//                           ),
//                           // End time (on the left in RTL)
//                           Flexible(
//                             child: Text(
//                               'صباحا ${time[1]}',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 13.sp,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
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
          // Header with icon
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
          // Time slots grid
          LayoutBuilder(
            builder: (context, constraints) {
              // حساب عرض كل كارد بناءً على عرض الشاشة
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
                          // Start time (on the right in RTL)
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
                          // Double arrow icon
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
                          // End time (on the left in RTL)
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
