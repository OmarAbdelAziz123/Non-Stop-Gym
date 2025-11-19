import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:non_stop/core/constants/app_colors.dart';
import 'package:non_stop/core/constants/app_styles.dart';
import 'package:non_stop/core/extensions/navigation_extension.dart';
import 'package:non_stop/core/routing/app_router.dart';
import 'package:non_stop/core/routing/routes_name.dart';
import 'package:non_stop/core/widgets/button/custom_button_widget.dart';
import 'package:non_stop/features/main%20layout/business_logic/main_layout_cubit.dart';
import 'package:non_stop/features/photo%20gallery/bloc/cubit/gallery_cubit.dart';
import 'package:non_stop/features/photo%20gallery/data/models/gallery_response.dart';

class PhotoGalleryScreen extends StatefulWidget {
  const PhotoGalleryScreen({super.key});

  @override
  State<PhotoGalleryScreen> createState() => _PhotoGalleryScreenState();
}

class _PhotoGalleryScreenState extends State<PhotoGalleryScreen> {
  final ScrollController _scrollController = ScrollController();
  final ScrollController _horizontalScrollController = ScrollController();
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch galleries when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GalleryCubit>().getAllGalleries();
    });

    // Setup scroll listener for pagination
    _scrollController.addListener(_onScroll);
    _horizontalScrollController.addListener(_onHorizontalScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _horizontalScrollController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      final cubit = context.read<GalleryCubit>();
      if (!cubit.isLoadingMore && cubit.hasMorePages) {
        cubit.getAllGalleries(loadMore: true);
      }
    }
  }

  void _onHorizontalScroll() {
    if (_horizontalScrollController.position.pixels >=
        _horizontalScrollController.position.maxScrollExtent * 0.8) {
      final cubit = context.read<GalleryCubit>();
      if (!cubit.isLoadingMore && cubit.hasMorePages) {
        cubit.getAllGalleries(loadMore: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GalleryCubit>();
    return Container(
      decoration: const BoxDecoration(color: Color(0xff160618)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        MainLayoutCubit.get(context).changeBottomNavBar(0);
                      },
                      child: Container(
                        width: 44.w,
                        height: 44.h,
                        decoration: BoxDecoration(
                          color: const Color(0xff2A1A2C),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Transform.rotate(
                          angle: context.locale.languageCode == 'en'
                              ? math.pi
                              : 0,
                          child: SvgPicture.asset(
                            "assets/svgs/Back _con.svg",
                            width: 24.w,
                            height: 24.h,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'photoGallery'.tr(),
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
              ),
              Expanded(
                child: BlocListener<GalleryCubit, GalleryState>(
                  listenWhen: (previous, current) =>
                      current is GalleryUploadSuccess ||
                      current is GalleryUploadFailure,
                  listener: (context, state) {
                    if (state is GalleryUploadSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                          backgroundColor: Colors.green,
                        ),
                      );
                      _commentController.clear();
                    } else if (state is GalleryUploadFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: BlocBuilder<GalleryCubit, GalleryState>(
                    buildWhen: (previous, current) =>
                        current is GalleryLoading ||
                        current is GallerySuccess ||
                        current is GalleryFailure ||
                        current is GalleryLoadMoreLoading ||
                        current is GalleryLoadMoreSuccess ||
                        current is GalleryLoadMoreFailure ||
                        current is GalleryUploadLoading,
                    builder: (context, state) {
                      if (state is GalleryLoading) {
                        return ListView(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          children: [
                            20.verticalSpace,
                            _buildSkeletonUserList(),
                            50.verticalSpace,
                            _buildAddPostSection(cubit),
                          ],
                        );
                      }

                      if (state is GalleryFailure) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                state.message,
                                style: Styles.featureSemibold.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              16.verticalSpace,
                              ElevatedButton(
                                onPressed: () {
                                  cubit.getAllGalleries();
                                },
                                child: Text('retry'.tr()),
                              ),
                            ],
                          ),
                        );
                      }

                      final galleryItems = cubit.galleryItems;
                      // final allUniqueUsers = _getUniqueUsers(galleryItems);
                      // // Show 10 users per page: page 1 = 10 users, page 2 = 20 users, etc.
                      // final displayedUsersCount = (cubit.currentPage * 10)
                      //     .clamp(0, allUniqueUsers.length);
                      // final displayedUsers = allUniqueUsers
                      //     .take(displayedUsersCount)
                      //     .toList();
                      // print(displayedUsers.length);
                      final displayedUsers = galleryItems;
                      return ListView(
                        controller: _scrollController,
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        children: [
                          20.verticalSpace,

                          // Users horizontal list
                          if (displayedUsers.isNotEmpty)
                            SizedBox(
                              height: 100.h,
                              child: ListView.separated(
                                controller: _horizontalScrollController,
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    displayedUsers.length +
                                    (cubit.isLoadingMore ? 1 : 0),
                                separatorBuilder: (context, index) =>
                                    12.horizontalSpace,
                                itemBuilder: (context, index) {
                                  // Show loading indicator at the end
                                  if (index >= displayedUsers.length) {
                                    return const Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  }
                                  final user = displayedUsers[index];
                                  return InkWell(
                                    onTap: () {
                                      // Filter gallery items by this user

                                      context.pushNamed(
                                        Routes.photoGalleryDetailsScreen,
                                        arguments: PhotoGalleryDetailsArgs(
                                          image:
                                              displayedUsers[index]
                                                  .user
                                                  ?.image ??
                                              'https://via.placeholder.com/150',
                                          name: user.user?.name ?? 'no name',
                                          description:
                                              user.comment ?? 'no description',
                                          image2: user.image ?? '',
                                        ),
                                      );
                                    },

                                    child: Column(
                                      children: [
                                        Container(
                                          width: 64.w,
                                          height: 64.h,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: const Color(0xff9F5A5B),
                                              width: 2,
                                            ),
                                          ),
                                          child: ClipOval(
                                            child:
                                                user.image != null &&
                                                    user.image!.isNotEmpty
                                                ? CachedNetworkImage(
                                                    imageUrl: user.image!,
                                                    fit: BoxFit.cover,
                                                    placeholder:
                                                        (
                                                          context,
                                                          url,
                                                        ) => Container(
                                                          color:
                                                              Colors.grey[800],
                                                          child: const Center(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          ),
                                                        ),
                                                    errorWidget:
                                                        (
                                                          context,
                                                          url,
                                                          error,
                                                        ) => Image.asset(
                                                          "assets/pngs/image2.png",
                                                          fit: BoxFit.cover,
                                                        ),
                                                  )
                                                : Image.asset(
                                                    "assets/pngs/image2.png",
                                                    fit: BoxFit.cover,
                                                  ),
                                          ),
                                        ),
                                        6.verticalSpace,
                                        Text(
                                          user.user?.name ?? 'no name',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w700,
                                            fontFamily:
                                                GoogleFonts.cairo().fontFamily,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),

                          50.verticalSpace,
                          _buildAddPostSection(cubit),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddPostSection(GalleryCubit cubit) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            'addPost'.tr(),
            style: Styles.highlightBold.copyWith(color: Colors.white),
          ),
        ),
        20.verticalSpace,
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: const Color(0xff2A1A2C),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: TextFormField(
            controller: _commentController,
            maxLines: 3,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontFamily: GoogleFonts.cairo().fontFamily,
            ),
            decoration: InputDecoration(
              hintText: 'writeYourPostHere'.tr(),
              hintStyle: Styles.footnoteRegular.copyWith(
                color: AppColors.neutralColor400,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
        16.verticalSpace,
        BlocBuilder<GalleryCubit, GalleryState>(
          buildWhen: (previous, current) =>
              current is PickImageErrorState ||
              current is PickImageSuccessState,
          builder: (context, state) {
            return InkWell(
              onTap: () {
                cubit.pickFile();
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: const Color(0xff2A1A2C),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: cubit.selectedFile != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: Image.file(
                          cubit.selectedFile!,
                          width: double.infinity,
                          height: 200.h,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image_outlined,
                            color: AppColors.neutralColor400,
                            size: 40.sp,
                          ),
                          12.verticalSpace,
                          Text(
                            'uploadYourImageHere'.tr(),
                            style: Styles.footnoteRegular.copyWith(
                              color: AppColors.neutralColor400,
                            ),
                          ),
                        ],
                      ),
              ),
            );
          },
        ),
        24.verticalSpace,
        BlocBuilder<GalleryCubit, GalleryState>(
          buildWhen: (previous, current) =>
              current is GalleryUploadLoading ||
              current is GalleryUploadSuccess ||
              current is GalleryUploadFailure,
          builder: (context, state) {
            final isLoading = state is GalleryUploadLoading;
            return CustomButtonWidget(
              onPressed: isLoading
                  ? null
                  : () {
                      cubit.addGalleryItem(_commentController.text);
                    },
              text: 'publish'.tr(),
              color: const Color(0xff9F5A5B),
              textStyle: Styles.highlightBold.copyWith(color: Colors.white),
              borderRadius: 12.r,
              height: 56.h,
              isLoading: isLoading,
            );
          },
        ),
      ],
    );
  }

  List<GalleryUserModel> _getUniqueUsers(List<GalleryItemModel> items) {
    final Map<int, GalleryUserModel> uniqueUsersMap = {};
    for (var item in items) {
      if (item.user != null && item.user!.id != null) {
        uniqueUsersMap[item.user!.id!] = item.user!;
      }
    }
    return uniqueUsersMap.values.toList();
  }

  Widget _buildSkeletonUserList() {
    return _ShimmerWrapper(
      child: SizedBox(
        height: 100.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: 6,
          separatorBuilder: (context, index) => 12.horizontalSpace,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  width: 64.w,
                  height: 64.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[800],
                    border: Border.all(
                      color: const Color(0xff9F5A5B),
                      width: 2,
                    ),
                  ),
                ),
                6.verticalSpace,
                Container(
                  width: 60.w,
                  height: 14.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ShimmerWrapper extends StatefulWidget {
  const _ShimmerWrapper({required this.child});

  final Widget child;

  @override
  State<_ShimmerWrapper> createState() => _ShimmerWrapperState();
}

class _ShimmerWrapperState extends State<_ShimmerWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment(-1.0 - _controller.value * 2, 0.0),
              end: Alignment(1.0 - _controller.value * 2, 0.0),
              colors: [Colors.grey[800]!, Colors.grey[700]!, Colors.grey[800]!],
              stops: const [0.0, 0.5, 1.0],
            ).createShader(bounds);
          },
          child: widget.child,
        );
      },
    );
  }
}
