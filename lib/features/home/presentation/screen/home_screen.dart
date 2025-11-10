import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:non_stop/core/cache_helper/cache_helper.dart';
import 'package:non_stop/core/cache_helper/cache_keys.dart';
import 'package:non_stop/core/constants/app_colors.dart';
import 'package:non_stop/core/constants/app_styles.dart';
import 'package:non_stop/features/home/bloc/cubit/home_cubit.dart';
import 'package:non_stop/features/home/presentation/screen/gifts_tap.dart';
import 'package:non_stop/features/home/presentation/screen/relax_tap.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    final homeCubit = BlocProvider.of<HomeCubit>(context);

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xff160618),
        // gradient: LinearGradient(
        //   begin: Alignment.topCenter,
        //   end: Alignment.bottomCenter,
        //   colors: [Color(0xff160618), Color(0xff1C0617)],
        // ),
      ),
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom + 10.h,
          ),

          child: Column(
            children: [
              Container(
                height: 400.sp,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF2A2535),
                  borderRadius: BorderRadius.circular(26.r),
                  image: const DecorationImage(
                    image: AssetImage("assets/pngs/home_realx_icon.png"),
                    fit: BoxFit.cover,
                    opacity: 0.5,
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.sp,
                      vertical: 8.sp,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 45.sp,
                              height: 45.sp,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: CachedNetworkImage(
                                imageUrl:
                                    CacheHelper.getData(
                                      key: CacheKeys.userImage,
                                    ) ??
                                    "",
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                            10.horizontalSpace,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "welcome".tr(),
                                  style: Styles.contentRegular.copyWith(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  CacheHelper.getData(
                                        key: CacheKeys.userName,
                                      ) ??
                                      "mohamed hisham",
                                  style: Styles.contentRegular.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            IconButton(
                              icon: Container(
                                padding: EdgeInsets.all(12.sp),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  color: Colors.white.withValues(alpha: 0.1),
                                ),
                                child: SvgPicture.asset(
                                  "assets/svgs/Notification.svg",
                                  width: 20.w,
                                  height: 20.h,
                                ),
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        const Spacer(),
                        Text(
                          'ريلاكس',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: AppColors.neutralColor100,
                          ),
                        ),
                        const Text(
                          'دع التوتر جانبًا: لحظات من الهدوء.',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              5.verticalSpace,

              DotsIndicator(
                dotsCount: 3,
                position: 1.0,
                decorator: DotsDecorator(
                  activeColor: Color(0xffD9D9D9).withValues(alpha: 0.21),
                  color: const Color(0xffD9D9D9),
                  size: Size(35.r, 4.r),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  activeSize: Size(35.r, 4.r),
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (var i = 0; i < 3; i++)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTab = i;
                          });
                        },
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 21,
                                vertical: 18,
                              ),
                              decoration: BoxDecoration(
                                color: selectedTab == i
                                    ? const Color(0xff9F5A5B)
                                    : const Color(0xff02040B),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Image.asset(
                                i == 0
                                    ? 'assets/pngs/relax.png'
                                    : i == 1
                                    ? 'assets/pngs/device.png'
                                    : 'assets/pngs/offer2.png',
                                color: Colors.white,
                                width: 50.w,
                                height: 50.h,
                              ),
                            ),
                            10.verticalSpace,
                            Text(
                              i == 0
                                  ? 'ريلاكس'
                                  : i == 1
                                  ? 'اجهزة'
                                  : 'العروض',
                              style: Styles.contentRegular.copyWith(
                                color: selectedTab == i
                                    ? Colors.white
                                    : const Color(
                                        0xffFCFCFC,
                                      ).withValues(alpha: 0.60),
                                fontWeight: selectedTab == i
                                    ? FontWeight.bold
                                    : FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),

              selectedTab == 0
                  ? RelaxTap(times: times, selectedTimeSlot: selectedTimeSlot)
                  : selectedTab == 1
                  ? const SizedBox.shrink()
                  : GiftsTap(),
            ],
          ),
        ),
      ),
    );
  }
}
