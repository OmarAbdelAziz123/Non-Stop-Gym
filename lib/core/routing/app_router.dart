import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:non_stop/core/routing/routes_name.dart';
import 'package:non_stop/features/auth/business_logic/auth_cubit.dart';
import 'package:non_stop/features/auth/presentation/screens/create_new_password_screen.dart';
import 'package:non_stop/features/auth/presentation/screens/forget_password_screen.dart';
import 'package:non_stop/features/auth/presentation/screens/login_screen.dart';
import 'package:non_stop/features/auth/presentation/screens/register_screen.dart';
import 'package:non_stop/features/auth/presentation/screens/verify_otp_screen.dart';
import 'package:non_stop/features/home/bloc/cubit/home_cubit.dart';
import 'package:non_stop/features/home/presentation/screen/home_screen.dart';
import 'package:non_stop/features/main%20layout/business_logic/main_layout_cubit.dart';
import 'package:non_stop/features/main%20layout/presentation/main_layout.dart';
import 'package:non_stop/features/onboarding/onBoarding/Bloc/on_boarding_cubit.dart';
import 'package:non_stop/features/onboarding/onBoarding/screens/on_boarding_screen.dart';
import 'package:non_stop/features/photo%20gallery/presentation/screens/photo_gallery_screen.dart';
import 'package:non_stop/features/profile/presentation/screen/edit_profile_screen.dart';
import 'package:non_stop/features/profile/presentation/screen/profile_screen.dart';
import 'package:non_stop/features/splash/screens/splash_screen.dart';
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
        return transition(screen: const VerifyOTPScreen(), cubit: AuthCubit());
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
      case Routes.mainlayoutScreen:
        return transition(screen: MainLayoutScreen(), cubit: MainLayoutCubit());
      case Routes.splashScreen:
        return transition(screen: const SplashScreen());
      case Routes.registerScreen:
        return transition(screen: const RegisterScreen(), cubit: AuthCubit());
      case Routes.editProfileScreen:
        return transition(screen: const EditProfilePage());
    }
    return null;
  }

  List<Widget> gymScreen = [
    BlocProvider(create: (context) => HomeCubit(), child: HomeScreen()),
    SizedBox(),

    // SizedBox(),
    PhotoGalleryScreen(),

    ProfilePage(),
  ];
}
