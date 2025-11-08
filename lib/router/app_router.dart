import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:non_stop/common/widgets/error_screen.dart';
import 'package:non_stop/features/onboarding/screens/onboarding_screen.dart';
import 'package:non_stop/features/splash/screens/splash_screen.dart';
import 'package:non_stop/router/route_name.dart';
import 'package:page_transition/page_transition.dart';

/// 🔹 Central App Router
class AppRouter {
  AppRouter._();

  /// private constructor to prevent instantiation

  /// Generates a route based on RouteSettings
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;

    /// 🔹 Helper function to create page transitions with optional Bloc/Cubit injection
    PageTransition buildTransition<T extends Cubit<Object>>({
      required Widget screen,
      T? cubit,
      PageTransitionType type = PageTransitionType.fade,
      Duration duration = const Duration(milliseconds: 250),
      Alignment alignment = Alignment.center,
    }) {
      final child = cubit != null
          ? BlocProvider<T>(create: (_) => cubit, child: screen)
          : screen;

      return PageTransition(
        child: child,
        type: type,
        duration: duration,
        alignment: alignment,
        settings: settings,
      );
    }

    /// 🔹 Pattern matching routes
    switch (settings.name) {
      case RouteNames.splash:
        return buildTransition(
          screen: SplashScreen(),
        );
      case RouteNames.onboarding:
        return buildTransition(
          screen: OnboardingScreen(),
        );


    // Example route with arguments
    // case RouteNames.profile:
    //   if (args is String) {
    //     return buildTransition(
    //       screen: ProfileScreen(userId: args),
    //     );
    //   }
    //   return _errorRoute('ProfileScreen requires a String userId');

      default:
        return _errorRoute('Route not found');
    }
  }

  /// 🔹 Fallback route for undefined or error routes
  static Route<dynamic> _errorRoute(String message) {
    return MaterialPageRoute(
      settings: RouteSettings(name: RouteNames.error),
      builder: (_) => const ErrorScreenCard(),
    );
  }
}
