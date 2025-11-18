import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:non_stop/core/cache_helper/cache_helper.dart';
import 'package:non_stop/core/constants/app_constants.dart';
import 'package:non_stop/core/extensions/navigation_extension.dart';
import 'package:non_stop/core/routing/routes_name.dart';
import 'package:non_stop/core/theme/theme.dart';
import 'package:non_stop/core/widgets/custom_app_bar.dart';
import 'package:non_stop/features/profile/bloc/cubit/profile_cubit.dart';
import 'package:non_stop/features/profile/presentation/screen/edit_profile_screen.dart';
import 'package:non_stop/features/profile/presentation/widgets/language_selection_bottom_sheet.dart';
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
            CustomAppBar(title: 'myProfile'.tr(), hasLeading: false),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    10.verticalSpace,

                    BlocBuilder<ProfileCubit, ProfileState>(
                      builder: (context, state) {
                        final cubit = context.read<ProfileCubit>();

                        if (state is ProfileLoading &&
                            cubit.profileData == null) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 24),
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (state is ProfileError &&
                            cubit.profileData == null) {
                          return Column(
                            children: [
                              const SizedBox(height: 16),
                              Text(
                                state.message,
                                style:
                                    TextStyle(
                                      color: Colors.redAccent,
                                      fontFamily: GoogleFonts.cairo().fontFamily,
                                    ),
                              ),
                              const SizedBox(height: 12),
                              ElevatedButton(
                                onPressed: cubit.fetchProfile,
                                child: Text('retry'.tr()),
                              ),
                            ],
                          );
                        }

                        final profile = state is ProfileLoaded
                            ? state.profile
                            : cubit.profileData;

                        return ProfileCard(profile: profile);
                      },
                    ),

                    20.verticalSpace,

                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xff02040B),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          ProfileTile(
                            title: 'personalData'.tr(),
                            icon: Icons.person_outline,
                            onTap: () async {
                              final cubit = context.read<ProfileCubit>();
                              final didUpdate =
                                  await Navigator.of(context).push<bool>(
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                    value: cubit,
                                    child: const EditProfilePage(),
                                  ),
                                ),
                              );

                              if (didUpdate == true) {
                                if (cubit.profileData != null) {
                                  cubit.notifyProfileChanged();
                                } else {
                                  cubit.fetchProfile();
                                }
                              }
                            },
                          ),
                          ProfileTile(
                            title: 'myBookings'.tr(),
                            icon: Icons.event_note_outlined,
                            onTap: () {
                              context.pushNamed(Routes.myBookingScreen);
                            },
                          ),
                          ProfileTile(
                            onTap: () {
                              context.pushNamed(Routes.chagnePasswordScreen);
                            },
                            title: 'password'.tr(),
                            icon: Icons.lock_outline,
                          ),
                          ProfileTile(
                            title: 'myPackages'.tr(),
                            icon: Icons.credit_card_outlined,
                            onTap: () {
                              context.pushNamed(Routes.myPackagesScreen);
                            },
                          ),
                          ProfileTile(
                            title: 'appLanguage'.tr(),
                            icon: Icons.language_outlined,
                            onTap: () {
                              LanguageSelectionBottomSheet.show(context);
                            },
                          ),
                          ProfileTile(
                            onTap: () {
                              context.pushNamed(Routes.notificationScreen);
                            },
                            title: 'notifications'.tr(),
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
                        children: [
                          ProfileTile(
                            onTap: () {
                              context.pushNamed(
                                Routes.complaintsAndSuggetionsScreen,
                              );
                            },
                            title: 'complaintsAndSuggestions'.tr(),
                            icon: Icons.feedback_outlined,
                          ),
                          ProfileTile(
                            onTap: () {
                              context.pushNamed(Routes.faqScreen);
                            },
                            title: 'faqs'.tr(),
                            icon: Icons.help_outline,
                          ),
                        ],
                      ),
                    ),

                    30.verticalSpace,

                    OutlinedButton.icon(
                      onPressed: () async {
                        await CacheHelper.clearAllData();
                        await CacheHelper.clearAllSecuredData();
                        AppConstants.userToken = null;

                        if (!context.mounted) return;
                        context.pushNamedAndRemoveUntil(Routes.loginScreen);
                      },
                      icon: const Icon(Icons.logout, color: Colors.white),
                      label: Text(
                        'logout'.tr(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: GoogleFonts.cairo().fontFamily,
                        ),
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
                      label: Text(
                        'deleteAccount'.tr(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: GoogleFonts.cairo().fontFamily,
                        ),
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
