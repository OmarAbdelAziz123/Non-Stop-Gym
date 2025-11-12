import 'package:flutter/material.dart';
import 'package:non_stop/core/cache_helper/cache_helper.dart';
import 'package:non_stop/core/cache_helper/cache_keys.dart';
import 'package:non_stop/core/constants/app_constants.dart';
import 'package:non_stop/core/routing/routes_name.dart';
import 'package:non_stop/features/splash/widgets/animated_logo_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _handleNavigation());
  }

  Future<void> _handleNavigation() async {
    final token = await CacheHelper.getSecuredString(
      key: CacheKeys.userToken,
    );

    if (token is String && token.isNotEmpty) {
      AppConstants.userToken = token;
    }

    final hasToken = token is String && token.isNotEmpty;
    final targetRoute =
        hasToken ? Routes.mainlayoutScreen : Routes.onBoardingScreen;

    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;
    Navigator.pushReplacementNamed(context, targetRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF110707),
              Color(0xFF100000),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: const Center(
          child: AnimatedLogo(
            assetPath: 'assets/svgs/splash_logo.svg',
            width: 180,
            height: 82,
          ),
        ),
      ),
    );
  }
}
