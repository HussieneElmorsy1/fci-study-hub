// import 'dart:developer';
// import 'package:fci_app_new/data/models/status_model.dart';
// import 'package:fci_app_new/presentation/screens/more_screen.dart';
// import 'package:fci_app_new/presentation/screens/profile_screen.dart';
// import 'package:fci_app_new/presentation/screens/schedule_screen.dart';
// import 'package:fci_app_new/presentation/widgets/custom_bottom_nav_bar.dart';
// import 'package:fci_app_new/presentation/widgets/custom_side_menu.dart';
// import 'package:fci_app_new/presentation/widgets/home_widgets.dart';

// import 'package:fci_app_new/presentation/widgets/horizontal_line.dart';
// import 'package:fci_app_new/presentation/widgets/horizontal_courses_list.dart';
// import 'package:fci_app_new/presentation/widgets/status_bar.dart';
// import 'package:fci_app_new/styles/styles.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart'; // Import SystemNavigator
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart'; // Ensure Get is imported
// import 'package:google_fonts/google_fonts.dart';

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final PageController _pageController = PageController();
//   int _currentIndex = 0;

//   final List<Status> demoStatuses = [
//     Status(
//         username: 'محمود',
//         imageAsset: 'assets/images/home_screen/Ellipse_25.png',
//         isViewed: false),
//     Status(
//         username: 'أحمد',
//         imageAsset: 'assets/images/home_screen/Ellipse_26.png',
//         isViewed: true),
//     Status(
//         username: 'محمود',
//         imageAsset: 'assets/images/home_screen/Ellipse_27.png',
//         isViewed: true),
//   ];

//   String selectedGroup = '3.4'.tr; // Default group

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   void _showGroupMenu(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
//       builder: (context) => _buildGroupMenu(),
//     );
//   }

//   Widget _buildGroupMenu() {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: ['3.2', '3.3', '3.4', '3.5']
//           .map((groupName) => _buildMenuItem(groupName.tr))
//           .toList(),
//     );
//   }

//   Widget _buildMenuItem(String groupName) {
//     return ListTile(
//       title:
//           Center(child: Text(groupName, style: const TextStyle(fontSize: 18))),
//       onTap: () {
//         setState(() {
//           selectedGroup = groupName;
//         });
//         Get.back(); // Close the bottom sheet
//       },
//     );
//   }

//   void _onBottomNavTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//     _pageController.jumpToPage(index);
//   }

//   @override
//   Widget build(BuildContext context) {
//     // ignore: deprecated_member_use
//     return WillPopScope(
//       onWillPop: () async {
//         if (_currentIndex == 0) {
//           Get.back(); // Close app
//           return true;
//         } else {
//           _pageController.jumpToPage(0);
//           setState(() {
//             _currentIndex = 0;
//           });
//           return false;
//         }
//       },
//       child: Scaffold(
//         backgroundColor:Theme.of(context).scaffoldBackgroundColor,
//         appBar: _buildAppBar(),
//         body: PageView(
//           controller: _pageController,
//           onPageChanged: (index) => setState(() {
//             _currentIndex = index;
//           }),
//           children: [
//             _buildHomePage(),
//             const ScheduleScreen(),
//             ProfileScreen(),
//             const MoreScreen(),
//           ],
//         ),
//         bottomNavigationBar: CustomBottomNavBar(
//           currentIndex: _currentIndex,
//           onTap: _onBottomNavTapped,
//         ),
//       ),
//     );
//   }

//   AppBar _buildAppBar() {
//     return AppBar(
//       backgroundColor: Colors.white,
//       elevation: 0,
//       title: FittedBox(
//         fit: BoxFit.scaleDown,
//         child: Text(
//           '3.1'.tr,
//           style: AppTextStyles.bodyText,
//         ),
//       ),
//       centerTitle: true,
//       leading: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: CircleAvatar(
//           backgroundColor: Colors.grey[200],
//           child: Image.asset('assets/images/fci_logo_1.png'),
//         ),
//       ),
//       actions: [
//         IconButton(
//           icon: const Icon(Icons.search, color: Colors.black),
//           onPressed: () {},
//         ),
//       ],
//     );
//   }

//   Widget _buildHomePage() {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//         child: Column(
//           children: [
//             AppGaping.kGap50,
//             _buildTopImages(),
//             AppGaping.kGap10,
//             _buildGroupSelection(),
//             AppGaping.kGap10,
//             _buildSideMenu(),
//             AppGaping.kGap10,
//             const HorizontalLine(),
//             AppGaping.kGap10,
//             _buildSectionTitle('3.12'.tr),
//             StatusBar(statuses: demoStatuses),
//             AppGaping.kGap10,
//             const HorizontalLine(),
//             AppGaping.kGap10,
//             _buildSectionTitle('3.13'.tr),
//             AppGaping.kGap10,
//             HorizontalCoursesList(),
//           ],
//         ),
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
//                 colors: [Color(0xFF074F83), Color(0xFF0C8CE9)],
//               ),
//             ),
//           ),
//           Positioned(
//             top: -18,
//             left: 0,
//             right: 0,
//             child: Center(
//               child: SvgPicture.asset('assets/images/home_screen/bro.svg'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildGroupSelection() {
//     return GroupSelection(
//       selectedGroup: selectedGroup,
//       showGroupMenu: _showGroupMenu,
//     );
//   }

//   Widget _buildSideMenu() {
//     return SideMenu(
//       items: [
//         SideMenuItem(
//             svgAsset: 'assets/images/home_screen/audience.svg',
//             title: '3.6'.tr),
//         SideMenuItem(
//             svgAsset: 'assets/images/home_screen/calendar.svg',
//             title: '3.7'.tr),
//         SideMenuItem(
//             svgAsset: 'assets/images/home_screen/notes.svg', title: '3.8'.tr),
//         SideMenuItem(
//             svgAsset: 'assets/images/home_screen/chat.svg', title: '3.9'.tr),
//         SideMenuItem(
//             svgAsset: 'assets/images/home_screen/settings.svg',
//             title: '3.10'.tr),
//         SideMenuItem(
//             svgAsset: 'assets/images/home_screen/add.svg', title: '3.11'.tr),
//       ],
//       onItemSelected: (index) => print('Selected item at index: $index'),
//     );
//   }

//   Widget _buildSectionTitle(String title) {
//     return Row(
//       children: [
//         Text(
//           title,
//           textAlign: TextAlign.right,
//           style: GoogleFonts.cairo(
//             fontSize: 20,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ],
//     );
//   }
// }
