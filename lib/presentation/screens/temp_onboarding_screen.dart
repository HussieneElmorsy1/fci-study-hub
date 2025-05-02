// import 'package:fci_app/app_routes.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({super.key});

//   static const String id = "/onboarding";

//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen> {
//   final controller = PageController();
//   bool isLastPage = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         padding: const EdgeInsets.only(bottom: 80),
//         child: PageView(
//           controller: controller,
//           onPageChanged: (index) {
//             setState(() => isLastPage = index == 4);
//           },
//           children: [
//             _buildPage(Colors.red, "Page 1"),
//             _buildPage(Colors.yellow, "Page 2"),
//             _buildPage(Colors.black, "Page 3"),
//             _buildPage(Colors.blue, "Page 4"),
//             _buildPage(Colors.pink, "Page 5"),
//           ],
//         ),
//       ),
//       bottomSheet:
//           isLastPage ? _buildGetStartedButton() : _buildNavigationControls(),
//     );
//   }

//   Widget _buildPage(Color color, String text) {
//     return Container(
//       color: color,
//       child: Center(child: Text(text)),
//     );
//   }

//   Widget _buildGetStartedButton() {
//     return TextButton(
//       style: TextButton.styleFrom(
//         minimumSize: const Size.fromHeight(80),
//       ),
//       onPressed: () async {
//         // navigate to the home screen
//         final prefs = await SharedPreferences.getInstance();
//         await prefs.setBool("onboarding_completed", true); // Set onboarding completed
//         Get.offNamed(AppRoutes.HOME); // Navigate directly to HomeScreen
//       },
//       child: const Text("Get Started", style: TextStyle(fontSize: 24)),
//     );
//   }

//   Widget _buildNavigationControls() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       height: 80,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           TextButton(
//             onPressed: () => controller.jumpToPage(4),
//             child: const Text("SKIP"),
//           ),
//           SmoothPageIndicator(
//             controller: controller,
//             count: 5,
//             effect: const JumpingDotEffect(
//               dotColor: Color(0xFF0C8CE9),
//               activeDotColor: Color(0xFF0C8CE9),
//               spacing: 16.0,
//             ),
//           ),
//           TextButton(
//             onPressed: () => controller.nextPage(
//               duration: const Duration(milliseconds: 500),
//               curve: Curves.easeInOut,
//             ),
//             child: const Text("NEXT"),
//           ),
//         ],
//       ),
//     );
//   }
// }
