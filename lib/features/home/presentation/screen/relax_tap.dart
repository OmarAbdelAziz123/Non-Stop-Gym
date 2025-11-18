import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:non_stop/core/extensions/navigation_extension.dart';
import 'package:non_stop/core/routing/routes_name.dart';
import 'package:non_stop/core/theme/app_colors.dart';
import 'package:non_stop/core/theme/text_colors.dart';
import 'package:non_stop/core/widgets/button/custom_button_widget.dart';
import 'package:non_stop/features/home/bloc/cubit/home_cubit.dart';
import 'package:non_stop/features/home/presentation/widgets/calender_widget.dart';
import 'package:non_stop/features/home/presentation/widgets/time_slots_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class RelaxTap extends StatelessWidget {
  const RelaxTap({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<HomeCubit>(context);

    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current is HomeSettingsLoading ||
          current is HomeSettingsSuccess ||
          current is HomeSettingsFailure ||
          current is HomeSlotsLoading ||
          current is HomeSlotsSuccess ||
          current is HomeSlotsFailure ||
          current is BookChangeDateState,
      builder: (context, state) {
        final settings = homeCubit.settings;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 17.0,
                vertical: 21,
              ),
              child: Text(
                'availableAppointments'.tr(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: GoogleFonts.cairo().fontFamily,
                ),
              ),
            ),
            CalenderWidget(homeCubit: homeCubit),

            BlocBuilder<HomeCubit, HomeState>(
              buildWhen: (previous, current) =>
                  current is HomeSlotsLoading ||
                  current is HomeSlotsSuccess ||
                  current is HomeSlotsFailure ||
                  current is BookChangeDateState ||
                  current is HomeBookingLoading ||
                  current is HomeBookingSuccess ||
                  current is HomeBookingFailure,
              builder: (context, state) {
                if (state is HomeSlotsLoading) {
                  return Padding(
                    padding: EdgeInsets.all(16.w),
                    child: const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  );
                }

                if (state is HomeSlotsFailure) {
                  return Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Center(
                      child: Text(
                        state.message,
                        style: TextStyle(
                          color: Colors.white70,
                          fontFamily: GoogleFonts.cairo().fontFamily,
                        ),
                      ),
                    ),
                  );
                }

                final slots = homeCubit.availableSlots;
                if (slots.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Center(
                      child: Text(
                        'noSlotsAvailable'.tr(),
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16.sp,
                          fontFamily: GoogleFonts.cairo().fontFamily,
                        ),
                      ),
                    ),
                  );
                }

                return Column(
                  children: [
                    TimeSlotsWidget(
                      slots: slots,
                      selectedSlotId: homeCubit.selectedSlot?.id,
                      onSlotSelected: (slot) {
                        homeCubit.selectSlot(slot);
                      },
                    ),
                    // Show Book now button when a slot is selected
                    if (homeCubit.selectedSlot != null)
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 16.h,
                        ),
                        child: BlocBuilder<HomeCubit, HomeState>(
                          buildWhen: (previous, current) =>
                              current is HomeBookingLoading ||
                              current is HomeBookingSuccess ||
                              current is HomeBookingFailure,
                          builder: (context, bookingState) {
                            final isLoading =
                                bookingState is HomeBookingLoading;

                            return CustomButtonWidget(
                              onPressed: isLoading
                                  ? null
                                  : () {
                                      homeCubit.bookBooking();
                                    },
                              text: isLoading
                                  ? 'bookingInProgress'.tr()
                                  : 'Book now'.tr(),
                              color: const Color(0xFF9F5A5B),
                              textColor: Colors.white,
                              height: 56.h,
                            );
                          },
                        ),
                      ),
                    // Show success/error messages
                    BlocListener<HomeCubit, HomeState>(
                      listenWhen: (previous, current) =>
                          current is HomeBookingSuccess ||
                          current is HomeBookingFailure,
                      listener: (context, state) {
                        if (state is HomeBookingSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.message),
                              backgroundColor: Colors.green,
                            ),
                          );
                        } else if (state is HomeBookingFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.message),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      child: const SizedBox.shrink(),
                    ),
                  ],
                );
              },
            ),
            Image.asset("assets/pngs/about_us.png"),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                settings?.aboutUs ?? 'aboutUsFallback'.tr(),
                style: Styles.contentRegular.copyWith(
                  color: AppColors.neutralColor200,
                ),
              ),
            ),
            SizedBox(height: 8),

            Image.asset("assets/pngs/eyes.png"),
            SizedBox(height: 8),

            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                settings?.ourVision ?? 'ourVisionFallback'.tr(),
                style: Styles.contentRegular.copyWith(
                  color: AppColors.neutralColor200,
                ),
              ),
            ),
            SizedBox(height: 15.h),
            CustomButtonWidget(
              margin: EdgeInsets.only(right: 17.sp, left: 17.sp),
              onPressed: () {
                context.pushNamed(Routes.moreAboutUsScreen);
              },
              text: 'moreAboutUs'.tr(),
              textStyle: Styles.contentRegular.copyWith(
                color: AppColors.neutralColor100,
              ),
              color: const Color(0xFF9F5A5B),
              height: 56.h,
            ),
            20.verticalSpace,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 17.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'contactUs'.tr(),
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: GoogleFonts.cairo().fontFamily,
                    ),
                  ),
                  SizedBox(height: 24),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xff727272).withValues(alpha: 0.50),
                        width: 0.5.w,
                      ),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/svgs/phone.svg'),
                        13.horizontalSpace,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'phoneNumber'.tr(),
                                style: Styles.highlightEmphasis.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              3.verticalSpace,
                              Text(
                                settings?.phone ?? '+971 54 454 2141',
                                style: Styles.highlightEmphasis.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            final phone = settings?.phone ?? '+971 54 454 2141';
                            final uri = Uri.parse('tel:$phone');
                            if (await canLaunchUrl(uri)) {
                              await launchUrl(uri);
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(12.sp),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xff9F5A5B),
                                width: 0.5.w,
                              ),
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Text(
                              'callUs'.tr(),
                              style: Styles.highlightStandard.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xff727272).withValues(alpha: 0.50),
                        width: 0.5.w,
                      ),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/svgs/email.svg'),
                        13.horizontalSpace,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'email'.tr(),
                                style: Styles.highlightEmphasis.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              3.verticalSpace,
                              Text(
                                settings?.email ?? 'nonstop1@mail.com',
                                style: Styles.highlightEmphasis.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            final email =
                                settings?.email ?? 'nonstop1@mail.com';
                            Clipboard.setData(ClipboardData(text: email));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('emailCopied'.tr())),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(12.sp),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xff9F5A5B),
                                width: 0.5.w,
                              ),
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/svgs/copy.svg",
                                  width: 15.w,
                                  height: 15.h,
                                ),
                                5.horizontalSpace,
                                Text(
                                  'copy'.tr(),
                                  style: Styles.highlightStandard.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  InkWell(
                    onTap: () async {
                      final xLink = settings?.xLink;
                      if (xLink != null && xLink.isNotEmpty) {
                        final uri = Uri.parse(xLink);
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(
                            uri,
                            mode: LaunchMode.externalApplication,
                          );
                        }
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.w,
                          color: Color(0xff151515).withValues(alpha: 0.41),
                        ),
                        color: Color(0xff151515).withValues(alpha: 0.40),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.close, color: Colors.white),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'x'.tr(),
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: GoogleFonts.cairo().fontFamily,
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.chevron_right, color: Color(0xff9F5A5B)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  InkWell(
                    onTap: () async {
                      final facebookLink = settings?.facebookLink;
                      if (facebookLink != null && facebookLink.isNotEmpty) {
                        final uri = Uri.parse(facebookLink);
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(
                            uri,
                            mode: LaunchMode.externalApplication,
                          );
                        }
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.w,
                          color: Color(0xff151515).withValues(alpha: 0.41),
                        ),
                        color: Color(0xff151515).withValues(alpha: 0.40),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.facebook, color: Colors.white),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'facebook'.tr(),
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: GoogleFonts.cairo().fontFamily,
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.chevron_right, color: Color(0xff9F5A5B)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  InkWell(
                    onTap: () async {
                      final instagramLink = settings?.instagramLink;
                      if (instagramLink != null && instagramLink.isNotEmpty) {
                        final uri = Uri.parse(instagramLink);
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(
                            uri,
                            mode: LaunchMode.externalApplication,
                          );
                        }
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.w,
                          color: Color(0xff151515).withValues(alpha: 0.41),
                        ),
                        color: Color(0xff151515).withValues(alpha: 0.40),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.camera_alt, color: Colors.white),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'instagram'.tr(),
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: GoogleFonts.cairo().fontFamily,
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.chevron_right, color: Color(0xff9F5A5B)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  InkWell(
                    onTap: () async {
                      final whatsappLink = settings?.whatsappLink;
                      if (whatsappLink != null && whatsappLink.isNotEmpty) {
                        final uri = Uri.parse(whatsappLink);
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(
                            uri,
                            mode: LaunchMode.externalApplication,
                          );
                        }
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.w,
                          color: Color(0xff151515).withValues(alpha: 0.41),
                        ),
                        color: Color(0xff151515).withValues(alpha: 0.40),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.whatshot, color: Colors.white),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'whatsapp'.tr(),
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: GoogleFonts.cairo().fontFamily,
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.chevron_right, color: Color(0xff9F5A5B)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            44.verticalSpace,
            Image.asset("assets/pngs/room.png"),
          ],
        );
      },
    );
  }
}
