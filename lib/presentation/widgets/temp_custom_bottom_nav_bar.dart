// import 'package:flutter/material.dart';
// import 'package:fci_app/app_routes.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';

// class CustomBottomNavBar extends StatelessWidget {
//   final int currentIndex;
//   final Function(int) onTap; // Callback to update the current index
//   final bool enableHapticFeedback; // Optional haptic feedback

//   CustomBottomNavBar({
//     super.key,
//     required this.currentIndex,
//     required this.onTap,
//     this.enableHapticFeedback = true, // Default to true
//   });

//   final List<String> _routes = [
//     AppRoutes.HOME,
//     AppRoutes.SCHEDULE,
//     AppRoutes.PROFILE,
//     AppRoutes.MORE,
//   ];

//   final List<String> _labels = [
//     'الرئيسية',
//     'الجدول',
//     'الشخصية',
//     'المزيد',
//   ];

//   void _onItemTapped(int index) {
//     if (enableHapticFeedback) {
//       HapticFeedback.lightImpact(); // Provide haptic feedback on tap
//     }
//     onTap(index); // Call the onTap function to update the current index
//     Get.toNamed(_routes[index]); // Navigate to the selected route without resetting the stack
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       currentIndex: currentIndex,
//       onTap: _onItemTapped,
//       type: BottomNavigationBarType.fixed,
//       selectedItemColor: Colors.blue,
//       unselectedItemColor: Colors.grey,
//       items: List.generate(_labels.length, (index) {
//         return BottomNavigationBarItem(
//           icon: Icon(Icons.home_outlined), // You can customize icons for each item
//           activeIcon: Icon(Icons.home), // You can customize active icons for each item
//           label: _labels[index],
//         );
//       }),
//     );
//   }
// }
