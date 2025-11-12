import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:non_stop/core/cache_helper/cache_helper.dart';
import 'package:non_stop/core/cache_helper/cache_keys.dart';
import 'package:non_stop/core/constants/app_colors.dart';
import 'package:non_stop/core/constants/app_styles.dart';
import 'package:non_stop/features/home/bloc/cubit/home_cubit.dart';
import 'package:non_stop/features/home/data/models/banner_response.dart';
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
  late final PageController _bannerController;

  @override
  void initState() {
    super.initState();
    _bannerController = PageController();
    final homeCubit = context.read<HomeCubit>();
    if (homeCubit.banners.isEmpty) {
      homeCubit.fetchBanners();
    }
  }

  @override
  void dispose() {
    _bannerController.dispose();
    super.dispose();
  }

  Widget _buildBannerSection(HomeCubit homeCubit) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current is HomeBannersLoading ||
          current is HomeBannersSuccess ||
          current is HomeBannersFailure,
      builder: (context, state) {
        if (state is HomeBannersLoading && homeCubit.banners.isEmpty) {
          return _buildBannerPlaceholder();
        }

        if (state is HomeBannersFailure && homeCubit.banners.isEmpty) {
          return _buildBannerError(state.message, homeCubit);
        }

        final banners = homeCubit.banners;
        if (banners.isEmpty) {
          return _buildBannerPlaceholder();
        }

        if (_bannerController.hasClients &&
            _bannerController.page?.round() != homeCubit.currentBannerIndex) {
          _bannerController.animateToPage(
            homeCubit.currentBannerIndex,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
          );
        }

        return Column(
          children: [
            SizedBox(
              height: 400.sp,
              child: PageView.builder(
                controller: _bannerController,
                itemCount: banners.length,
                onPageChanged: homeCubit.changeBannerIndex,
                itemBuilder: (context, index) {
                  final banner = banners[index];
                  return _buildBannerCard(banner);
                },
              ),
            ),
            10.verticalSpace,
            if (banners.length > 1)
              DotsIndicator(
                dotsCount: banners.length,
                position: homeCubit.currentBannerIndex.toDouble(),
                decorator: DotsDecorator(
                  activeColor: const Color(0xffD9D9D9).withValues(alpha: 0.21),
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
              )
            else
              SizedBox(height: 18.h),
          ],
        );
      },
    );
  }

  Widget _buildBannerPlaceholder() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Container(
        height: 400.sp,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26.r),
          gradient: LinearGradient(
            colors: [
              const Color(0xFF2A2535),
              const Color(0xFF2A2535).withValues(alpha: 0.6),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: const Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildBannerError(String message, HomeCubit cubit) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Container(
        height: 400.sp,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26.r),
          color: const Color(0xFF2A2535),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.white70, size: 42),
            12.verticalSpace,
            Text(
              message,
              textAlign: TextAlign.center,
              style: Styles.contentRegular.copyWith(
                color: Colors.white70,
              ),
            ),
            12.verticalSpace,
            TextButton(
              onPressed: cubit.fetchBanners,
              child: const Text(
                'إعادة المحاولة',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBannerCard(BannerModel banner) {
    final userName =
        CacheHelper.getData(key: CacheKeys.userName) as String? ?? '';
    final userImage =
        CacheHelper.getData(key: CacheKeys.userImage) as String? ?? '';

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.h),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(26.r),
        child: Stack(
          fit: StackFit.expand,
          children: [
            SizedBox.expand(
              child: CachedNetworkImage(
                imageUrl: banner.image ?? '',
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: const Color(0xFF2A2535),
                ),
                errorWidget: (context, url, error) => Container(
                  color: const Color(0xFF2A2535),
                  child: const Icon(Icons.image_not_supported_outlined,
                      color: Colors.white54, size: 40),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.35),
                    Colors.black.withValues(alpha: 0.75),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      Container(
                        width: 45.sp,
                        height: 45.sp,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: CachedNetworkImage(
                          imageUrl: userImage,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error, color: Colors.white),
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
                            userName.isNotEmpty ? userName : "mohamed hisham",
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
                    banner.title ?? '',
                    style: Styles.heading1.copyWith(
                      color: AppColors.neutralColor100,
                      fontSize: 28.sp,
                    ),
                  ),
                  8.verticalSpace,
                  Text(
                    banner.description ?? '',
                    style: Styles.contentRegular.copyWith(
                      color: Colors.white,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
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
              _buildBannerSection(homeCubit),

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
