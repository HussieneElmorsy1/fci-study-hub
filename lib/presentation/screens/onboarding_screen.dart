import 'package:fci_app_new/app_pages/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../styles/styles.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  static const String id = "/onboarding";

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() => isLastPage = index == 4);
          },
          children: [
            _buildPage(
              'assets/images/onboarding_screen/Group_136.svg',
              "5.1".tr, // "Welcome to FCI App",
            ),
            _buildPage(
              'assets/images/onboarding_screen/Group_364.svg',
              "5.2".tr, // We offer you an integrated educational platform
            ),
            _buildPage(
              'assets/images/onboarding_screen/amico.svg',
              "5.3".tr, // Browse all the faculty news
            ),
            _buildPage(
              'assets/images/onboarding_screen/cuate.svg',
              "5.4".tr, // Check your daily lessons and weekly schedule
            ),
            _buildPage(
              'assets/images/onboarding_screen/rafiki.svg',
              "5.5".tr, // Confirm your attendance
            ),
          ],
        ),
      ),
      bottomSheet:
          isLastPage ? _buildGetStartedButton() : _buildNavigationControls(),
    );
  }

  Widget _buildPage(String image, String text) {
    return Container(
      // color: color,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              image,
              height: 300,
              width: 300,
            ),
            const SizedBox(height: 20),
            Stack(
              children: [
                Text(text, style: AppTextStyles.headline1),
                Text(text, style: AppTextStyles.headline1Fill),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGetStartedButton() {
    return TextButton(
      style: TextButton.styleFrom(
        minimumSize: const Size.fromHeight(80),
      ),
      onPressed: () async {
        // Navigate to the home screen
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool(
            "onboarding_completed", true); // Set onboarding completed
        Get.offNamed(AppRoutes.LOGIN); // Navigate to HomeScreen
      },
      child: Text(
        "5.6".tr, //Get Started
        style: AppTextStyles.bodyText,
      ),
    );
  }

  Widget _buildNavigationControls() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () => controller.jumpToPage(4),
            child: Text(
              '5.7'.tr,
              style: AppTextStyles.bodyText,
            ), // Skip
          ),
          SmoothPageIndicator(
            controller: controller,
            count: 5,
            effect: const JumpingDotEffect(
              dotColor: Color(0xFF0C8CE9),
              activeDotColor: Color(0xFF0C8CE9),
              spacing: 16.0,
            ),
          ),
          TextButton(
            onPressed: () {
              controller.nextPage(
                duration: const Duration(milliseconds: 2000),
                curve: Curves.easeInOut,
              );
            },
            child: Text('5.8'.tr,
            style: AppTextStyles.bodyText,), // Next
          ),
        ],
      ),
    );
  }
}
