import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    ['11:5', '12'],
    ['9:5', '10'],
    ['7:5', '8'],
  ];
  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<HomeCubit>(context);

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xff160618), Color(0xff1C0617)],
        ),
      ),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Massage Chair Image + Header
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
                                  ),
                                ),
                                Text(
                                  CacheHelper.getData(
                                        key: CacheKeys.userName,
                                      ) ??
                                      "mohamed hisham",
                                  style: Styles.contentRegular.copyWith(
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            IconButton(
                              icon: Container(
                                padding: EdgeInsets.all(10.sp),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  color: Colors.white.withOpacity(0.1),
                                ),
                                child: const Icon(
                                  Icons.notifications,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        const Spacer(),
                        const Text(
                          'ريلاكس',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          'حرر نفسك وخذ لحظات من الهدوء',
                          style: TextStyle(fontSize: 14, color: Colors.white60),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              5.verticalSpace,

              // Dots Indicator
              DotsIndicator(
                dotsCount: 3,
                position: 1.0,
                decorator: DotsDecorator(
                  activeColor: AppColors.primaryColor900,
                  color: const Color(0xff7E7E7E),
                  size: Size(30.r, 5.r),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  activeSize: Size(30.r, 5.r),
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ),

              // Tabs
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
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
                                horizontal: 24,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: selectedTab == i
                                    ? const Color(0xff9f5a5b)
                                    : const Color(0xff02040B),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                i == 0
                                    ? Icons.card_giftcard
                                    : i == 1
                                    ? Icons.discount
                                    : Icons.chair,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                            Text(
                              i == 0
                                  ? 'الهدايا'
                                  : i == 1
                                  ? 'التخفيض'
                                  : 'ريلاكس',
                              style: Styles.contentRegular,
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              selectedTab == 0
                  ? GiftsTap()
                  : selectedTab == 1
                  ? const SizedBox.shrink()
                  : RelaxTap(times: times, selectedTimeSlot: selectedTimeSlot),

              // Availability Section
            ],
          ),
        ),
      ),
    );
  }
}
