import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:non_stop/core/constants/app_constants.dart';
import 'package:non_stop/core/routing/app_router.dart';
import 'package:non_stop/features/main%20layout/business_logic/main_layout_cubit.dart';
import 'package:non_stop/features/main%20layout/business_logic/main_layout_state.dart';

class MainLayoutScreen extends StatelessWidget {
  const MainLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainLayoutCubit, MainLayoutState>(
      builder: (BuildContext context, state) {
        final cubit = MainLayoutCubit.get(context);

        return Scaffold(
          body: AppRouter()
              .gymScreen[AppConstants.mainLayoutInitialScreenIndex],
          bottomNavigationBar: _buildBottomNav(cubit),
        );
      },
    );
  }

  /// 🔸 Custom Bottom Navigation Bar
  Widget _buildBottomNav(MainLayoutCubit cubit) {
    final currentIndex = AppConstants.mainLayoutInitialScreenIndex;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        color: Color(0xFF2A2535),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            icon: Icons.home_rounded,
            label: 'home'.tr(),
            isActive: currentIndex == 0,
            onTap: () => cubit.changeBottomNavBar(0),
          ),
          _buildNavItem(
            icon: Icons.apartment_rounded,
            label: 'projects'.tr(),
            isActive: currentIndex == 1,
            onTap: () => cubit.changeBottomNavBar(1),
          ),
          _buildNavItem(
            icon: Icons.calendar_today_rounded,
            label: 'allMettings'.tr(),
            isActive: currentIndex == 2,
            onTap: () => cubit.changeBottomNavBar(2),
          ),
          _buildNavItem(
            icon: Icons.more_horiz_rounded,
            label: 'more'.tr(),
            isActive: currentIndex == 3,
            onTap: () => cubit.changeBottomNavBar(3),
          ),
        ],
      ),
    );
  }

  /// 🔸 Custom Nav Item Widget
  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? const Color(0xFF8B6B6B) : Colors.white54,
            size: 24.sp,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isActive ? const Color(0xFF8B6B6B) : Colors.white54,
              fontSize: 11.sp,
            ),
          ),
        ],
      ),
    );
  }
}
