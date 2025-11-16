import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:non_stop/core/routing/routes_name.dart';
import 'package:non_stop/features/auth/business_logic/auth_cubit.dart';
import 'package:non_stop/features/auth/presentation/screens/create_new_password_screen.dart';
import 'package:non_stop/features/auth/presentation/screens/forget_password_screen.dart';
import 'package:non_stop/features/auth/presentation/screens/login_screen.dart';
import 'package:non_stop/features/auth/presentation/screens/register_screen.dart';
import 'package:non_stop/features/auth/presentation/screens/verify_otp_screen.dart';
import 'package:non_stop/features/change%20password/presentation/change_password_screen.dart';
import 'package:non_stop/features/complaints%20and%20suggestions/presentation/screens/Complaints%20_and%20_suggestions_screen.dart';
import 'package:non_stop/features/faq/presentation/screen/faq_screen.dart';
import 'package:non_stop/features/home/bloc/cubit/home_cubit.dart';
import 'package:non_stop/features/home/presentation/screen/home_screen.dart';
import 'package:non_stop/features/main%20layout/business_logic/main_layout_cubit.dart';
import 'package:non_stop/features/main%20layout/presentation/main_layout.dart';
import 'package:non_stop/features/more_about_us/presentation/screens/more_about_us_screen.dart';
import 'package:non_stop/features/notification/presentation/screens/notification_screen.dart';
import 'package:non_stop/features/onboarding/onBoarding/Bloc/on_boarding_cubit.dart';
import 'package:non_stop/features/onboarding/onBoarding/screens/on_boarding_screen.dart';
import 'package:non_stop/features/packages/bloc/cubit/packages_cubit.dart';
import 'package:non_stop/features/packages/presentation/screens/my_packages_screen.dart';
import 'package:non_stop/features/packages/presentation/screens/packages_screen.dart';
import 'package:non_stop/features/photo%20gallery%20details/presentation/screens/photo_gallery_details_screen.dart';
import 'package:non_stop/features/photo%20gallery/bloc/cubit/gallery_cubit.dart';
import 'package:non_stop/features/photo%20gallery/presentation/screens/photo_gallery_screen.dart';
import 'package:non_stop/features/profile/bloc/cubit/profile_cubit.dart';
import 'package:non_stop/features/profile/presentation/screen/edit_profile_screen.dart';
import 'package:non_stop/features/profile/presentation/screen/my_booking_screen.dart';
import 'package:non_stop/features/profile/presentation/screen/profile_screen.dart';
import 'package:non_stop/features/splash/screens/splash_screen.dart';
import 'package:non_stop/features/terms%20and%20condation/presenation/terms_and_condation.dart';
import 'package:non_stop/features/welcome/presentation/screen/welcome_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    MaterialPageRoute transition<T extends Cubit<Object>>({
      required Widget screen,
      T? cubit,
      Object? arguments,
    }) {
      final child = cubit != null
          ? BlocProvider<T>(create: (context) => cubit, child: screen)
          : screen;
      return MaterialPageRoute(settings: settings, builder: (context) => child);
    }

    switch (settings.name) {
      case Routes.welcomeScreen:
        return transition(screen: const WelcomeScreen());
      case Routes.loginScreen:
        return transition(screen: const LoginScreen(), cubit: AuthCubit());
      case Routes.forgetPasswordScreen:
        return transition(
          screen: const ForgetPasswordScreen(),
          cubit: AuthCubit(),
        );
      case Routes.verifyOTPScreen:
        // final args = settings.arguments as String;
        final args = settings.arguments as Map<String, dynamic>;
        
        return transition(screen: VerifyOTPScreen(arguments: args), cubit: AuthCubit());
      case Routes.createNewPasswordScreen:
        return transition(
          screen: const CreateNewPasswordScreen(),
          cubit: AuthCubit(),
        );
      case Routes.onBoardingScreen:
        return transition(
          screen: const OnBoardingScreen(),
          cubit: OnBoardingCubit(),
        );
      case Routes.faqScreen:
        return transition(
          screen: const FaqScreen(),
        );
      case Routes.mainlayoutScreen:
        return transition(screen: MainLayoutScreen(), cubit: MainLayoutCubit());
      case Routes.splashScreen:
        return transition(screen: const SplashScreen());
      case Routes.registerScreen:
        return transition(screen:  RegisterScreen(), cubit: AuthCubit());
      case Routes.editProfileScreen:
        return transition(
          screen: const EditProfilePage(),
          cubit: ProfileCubit()..fetchProfile(),
        );
      case Routes.photoGalleryDetailsScreen:
        final args = settings.arguments as PhotoGalleryDetailsArgs;
        return transition(
          screen: PhotoGalleryDetailsScreen(
            imagePath: args.image,
            name: args.name,
          ),
        );
      case Routes.myPackagesScreen:
        return transition(
          screen: const MyPackagesScreen(),
          cubit: PackagesCubit(),
        );
      case Routes.notificationScreen:
        return transition(screen: const NotificationScreen());

      case Routes.chagnePasswordScreen:
        return transition(
          screen: const ChangePasswordScreen(),
          cubit: ProfileCubit()..fetchProfile(),
        );
      case Routes.termsAndConditionsScreen:
        return transition(screen: const TermsConditionsScreen());
      case Routes.packagesScreen:
        return transition(
          screen: const PackagesScreen(),
          cubit: PackagesCubit()..fetchSubscriptions(),
        );
      case Routes.moreAboutUsScreen:
        return transition(
          screen: const MoreAboutUsScreen(),
          cubit: HomeCubit()..fetchSettings(),
        );
      case Routes.myBookingScreen:
        return transition(
          screen: const MyBookingScreen(),
          cubit: ProfileCubit()..fetchProfile(),
        );
      case Routes.complaintsAndSuggetionsScreen:
        return transition(screen: const ComplaintsAndSuggestionsScreen());
    }
    return null;
  }

  List<Widget> gymScreen = [
    BlocProvider(
      create: (context) => HomeCubit()..fetchBanners(),
      child: HomeScreen(),
    ),
    BlocProvider(
      create: (context) => PackagesCubit()..fetchSubscriptions(),
      child: PackagesScreen(),
    ),
    BlocProvider(
      create: (context) => GalleryCubit(),
      child: PhotoGalleryScreen(),
    ),
    BlocProvider(
      create: (context) => ProfileCubit()..fetchProfile(),
      child: ProfilePage(),
    ),
  ];
}

class PhotoGalleryDetailsArgs {
  final String image;
  final String name;

  PhotoGalleryDetailsArgs({required this.image, required this.name});
}
