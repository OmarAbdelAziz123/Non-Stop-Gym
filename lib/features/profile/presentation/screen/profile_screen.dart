import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:non_stop/core/extensions/navigation_extension.dart';
import 'package:non_stop/core/routing/routes_name.dart';
import 'package:non_stop/core/theme/theme.dart';
import 'package:non_stop/core/widgets/custom_app_bar.dart';
import 'package:non_stop/features/profile/presentation/widgets/profile_card.dart';
import 'package:non_stop/features/profile/presentation/widgets/profile_tile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: linearGradient),

      child: Scaffold(
        body: Column(
          children: [
            CustomAppBar(title: 'الملف الشخصي', hasLeading: false),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    10.verticalSpace,

                    const ProfileCard(),

                    20.verticalSpace,

                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xff02040B),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          ProfileTile(
                            title: 'البيانات الشخصية',
                            icon: Icons.person_outline,
                            onTap: () {
                              context.pushNamed(Routes.editProfileScreen);
                            },
                          ),
                          ProfileTile(
                            title: 'حجوزاتي',
                            icon: Icons.event_note_outlined,
                          ),
                          ProfileTile(
                            title: 'كلمة السر',
                            icon: Icons.lock_outline,
                          ),
                          ProfileTile(
                            title: 'بطاقاتي',
                            icon: Icons.credit_card_outlined,
                          ),
                          ProfileTile(
                            title: 'لغة التطبيق',
                            icon: Icons.language_outlined,
                          ),
                          ProfileTile(
                            title: 'الاشعارات',
                            icon: Icons.notifications_none,
                          ),
                        ],
                      ),
                    ),

                    20.verticalSpace,

                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xff02040B),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: const [
                          ProfileTile(
                            title: 'شكاوي و اقتراحات',
                            icon: Icons.feedback_outlined,
                          ),
                          ProfileTile(
                            title: 'الأسئلة الشائعة',
                            icon: Icons.help_outline,
                          ),
                          ProfileTile(
                            title: 'دعوة الأصدقاء',
                            icon: Icons.group_outlined,
                          ),
                        ],
                      ),
                    ),

                    30.verticalSpace,

                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.logout, color: Colors.white),
                      label: const Text(
                        'تسجيل خروج',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xff9F5A5B)),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                    ),

                    10.verticalSpace,

                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'حذف الحساب',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff9F5A5B),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
