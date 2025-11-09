import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:non_stop/core/constants/app_constants.dart';
import 'package:non_stop/core/routing/app_router.dart';
import 'package:non_stop/core/theme/text_colors.dart';
import 'package:non_stop/core/theme/theme.dart';
import 'package:non_stop/features/main%20layout/business_logic/main_layout_cubit.dart';
import 'package:non_stop/features/main%20layout/business_logic/main_layout_state.dart';

class MainLayoutScreen extends StatelessWidget {
  const MainLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainLayoutCubit, MainLayoutState>(
      builder: (BuildContext context, state) {
        final cubit = MainLayoutCubit.get(context);

        return Container(
          decoration: const BoxDecoration(gradient: linearGradient),
          child: Scaffold(
            body: AppRouter()
                .gymScreen[AppConstants.mainLayoutInitialScreenIndex],
            bottomNavigationBar: _buildBottomNav(cubit),
          ),
        );
      },
    );
  }

  Widget _buildBottomNav(MainLayoutCubit cubit) {
    final currentIndex = AppConstants.mainLayoutInitialScreenIndex;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        color: Color(0xFF02040B),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            svgPath: 'assets/svgs/home.svg',
            label: 'home'.tr(),
            isActive: currentIndex == 0,
            onTap: () => cubit.changeBottomNavBar(0),
          ),
          _buildNavItem(
            svgPath: 'assets/svgs/packages.svg',
            label: 'packages'.tr(),
            isActive: currentIndex == 1,
            onTap: () => cubit.changeBottomNavBar(1),
          ),
          _buildNavItem(
            svgPath: 'assets/svgs/gallery.svg',
            label: 'Photogallery'.tr(),
            isActive: currentIndex == 2,
            onTap: () => cubit.changeBottomNavBar(2),
          ),
          _buildNavItem(
            svgPath: 'assets/svgs/profile.svg',
            label: 'profile'.tr(),
            isActive: currentIndex == 3,
            onTap: () => cubit.changeBottomNavBar(3),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    IconData? icon,
    String? svgPath,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    Widget? iconWidget;

    if (icon != null) {
      iconWidget = Icon(
        icon,
        color: isActive ? const Color(0xFF9F5A5B) : const Color(0xFF8F8F8F),
        size: 24.sp,
      );
    } else if (svgPath != null) {
      iconWidget = SvgPicture.asset(
        svgPath,
        color: isActive ? const Color(0xFF9F5A5B) : const Color(0xFF8F8F8F),
        width: 24.w,
        height: 24.h,
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (iconWidget != null) iconWidget,
          SizedBox(height: 6.h),
          Text(
            label,
            style: Styles.footnoteRegular.copyWith(
              color: isActive
                  ? const Color(0xFF9F5A5B)
                  : const Color(0xFF8F8F8F),
            ),
          ),
        ],
      ),
    );
  }
}
