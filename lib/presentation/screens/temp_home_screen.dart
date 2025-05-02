// import 'dart:developer';

// import 'package:fci_app/data/models/status_model.dart';
// import 'package:fci_app/presentation/widgets/custom_bottom_nav_bar.dart';
// import 'package:fci_app/presentation/widgets/custom_side_menu.dart';
// import 'package:fci_app/presentation/widgets/horizental_line.dart';
// import 'package:fci_app/presentation/widgets/horizontal_courses_list.dart';
// import 'package:fci_app/presentation/widgets/status_bar.dart';
// import 'package:fci_app/styles/styles.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart'; // Ensure Get is imported
// import 'package:get/get_utils/src/extensions/internacionalization.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:fci_app/app_routes.dart'; // Import AppRoutes

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   static const String id = "/home";

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final PageController _pageController = PageController();
//   int _currentIndex = 0;

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   String selectedGroup = "3.4".tr; // Default group

//   final List<Status> demoStatuses = [
//     Status(
//       username: "محمد",
//       imageAsset: "assets/images/home_screen/Ellipse_25.png",
//       isViewed: false,
//     ),
//     Status(
//       username: "أحمد",
//       imageAsset: "assets/images/home_screen/Ellipse_26.png",
//       isViewed: true,
//     ),
//     Status(
//       username: "محمود",
//       imageAsset: "assets/images/home_screen/Ellipse_27.png",
//       isViewed: true,
//     ),
//   ];

//   void _showGroupMenu(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       builder: (context) {
//         return Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             _buildMenuItem("3.2".tr),
//             _buildMenuItem("3.3".tr),
//             _buildMenuItem("3.4".tr),
//             _buildMenuItem("3.5".tr),
//           ],
//         );
//       },
//     );
//   }

//   Widget _buildMenuItem(String groupName) {
//     return ListTile(
//       title: Center(
//         child: Text(
//           groupName,
//           style: const TextStyle(fontSize: 18),
//         ),
//       ),
//       onTap: () {
//         setState(() {
//           selectedGroup = groupName;
//         });
//         Navigator.pop(context);
//       },
//     );
//   }

//   void _onBottomNavTapped(int index) {
//     setState(() {
//       log(index.toString());
//       _currentIndex = index; // Update the current index
//     });

//     // Navigate to the corresponding screen based on the index
//     switch (index) {
//       case 0:
//         Get.toNamed(AppRoutes.HOME);
//         break;
//       case 1:
//         Get.toNamed(AppRoutes.SCHEDULE);
//         break;
//       case 2:
//         Get.toNamed(AppRoutes.PROFILE);
//         break;
//       case 3:
//         Get.toNamed(AppRoutes.MORE);
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: FittedBox(
//           fit: BoxFit.scaleDown,
//           child: Text(
//             "3.1".tr,
//             style: AppTextStyles.bodyText,
//           ),
//         ),
//         centerTitle: true,
//         leading: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: CircleAvatar(
//             backgroundColor: Colors.grey[200],
//             child: Image.asset("assets/images/fci_logo_1.png"),
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.search, color: Colors.black),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 8.0),
//           child: Column(
//             children: [
//               AppGaping.kGap50,
//               _buildTopImages(),
//               AppGaping.kGap10,
//               _buildGroupSelection(),
//               AppGaping.kGap10,
//               CustomSideMenu(
//                 items: [
//                   SideMenuItem(
//                     svgAsset: "assets/images/home_screen/audience.svg",
//                     title: 'الحضور',
//                   ),
//                   SideMenuItem(
//                     svgAsset: "assets/images/home_screen/calendar.svg",
//                     title: 'التقويم',
//                   ),
//                   SideMenuItem(
//                     svgAsset: "assets/images/home_screen/notes.svg",
//                     title: 'الملاحظات',
//                   ),
//                   SideMenuItem(
//                     svgAsset: "assets/images/home_screen/chat.svg",
//                     title: 'الدردشة',
//                   ),
//                   SideMenuItem(
//                     svgAsset: "assets/images/home_screen/settings.svg",
//                     title: 'الإعدادات',
//                   ),
//                   SideMenuItem(
//                     svgAsset: "assets/images/home_screen/add.svg",
//                     title: 'إضافة',
//                   ),
//                 ],
//                 onItemSelected: (index) {
//                   print('Selected item at index: $index');
//                 },
//               ),
//               AppGaping.kGap10,
//               const HorizontalLine(),
//               AppGaping.kGap10,
//               Row(
//                 children: [
//                   Text(
//                     "أخر الأخبار",
//                     textAlign: TextAlign.right,
//                     style: GoogleFonts.cairo(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ],
//               ),
//               StatusBar(statuses: demoStatuses),
//               AppGaping.kGap10,
//               const HorizontalLine(),
//               AppGaping.kGap10,
//               Row(
//                 children: [
//                   Text(
//                     "المقررات",
//                     textAlign: TextAlign.right,
//                     style: GoogleFonts.cairo(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ],
//               ),
//               AppGaping.kGap10,
//               HorizontalCoursesList(),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: CustomBottomNavBar(
//         currentIndex: _currentIndex,
//         onTap: _onBottomNavTapped, // Pass the onTap function
//       ),
//     );
//   }

//   Widget _buildTopImages() {
//     return Center(
//       child: Stack(
//         clipBehavior: Clip.none,
//         children: [
//           Container(
//             height: 125,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8),
//               gradient: const LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [
//                   Color(0xFF074F83),
//                   Color(0xFF0C8CE9),
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//             top: -18,
//             left: 0,
//             right: 0,
//             child: Center(
//               child: SvgPicture.asset(
//                 "assets/images/home_screen/bro.svg",
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildGroupSelection() {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: const [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 4,
//             spreadRadius: 1,
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Expanded(
//             child: Center(
//               child: Text(
//                 selectedGroup,
//                 style:
//                     const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//           GestureDetector(
//             onTap: () => _showGroupMenu(context),
//             child: Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: const Icon(Icons.tune, color: Colors.white),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
