import 'package:flutter/material.dart';
import 'package:non_stop/features/splash/widgets/animated_logo_widget.dart';
import 'package:non_stop/router/route_name.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// Schedule navigation after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context, RouteNames.onboarding);
      });
    });

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
