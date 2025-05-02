import 'package:fci_app_new/app_pages/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String id = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    
    // Initialize the animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3), // Duration for one complete rotation
    )..repeat(); // Make the animation repeat indefinitely
    
    // Automatic navigation after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      _checkOnboardingStatus();
    });
  }

  @override
  void dispose() {
    _animationController.dispose(); // Clean up the controller
    super.dispose();
  }

  Future<void> _checkOnboardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final onboardingCompleted = prefs.getBool('onboarding_completed') ?? false;

    if (onboardingCompleted) {
      Get.offNamed(AppRoutes.LOGIN);
    } else {
      Get.offNamed(AppRoutes.ONBOARDING);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            RotationTransition(
              turns: Tween(begin: 0.0, end: 1.0).animate(_animationController),
              child: Image.asset(
                'assets/images/fci_logo_border.png',
                width: 220,
                height: 220,
              ),
            ),
            Image.asset(
              'assets/images/image1.png',
              width: 150,
              height: 150,
            ),
          ],
        ),
      ),
    );
  }
}
