import 'package:fci_app_new/presentation/screens/home_screen.dart';
import 'package:fci_app_new/presentation/screens/more_screen.dart';
import 'package:fci_app_new/presentation/screens/profile_screen.dart';
import 'package:fci_app_new/presentation/screens/schedule_screen.dart';
import 'package:fci_app_new/presentation/widgets/custom_bottom_nav_bar.dart';
import 'package:fci_app_new/presentation/widgets/keep_alive_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({Key? key}) : super(key: key);

  @override
  _MainHomeScreenState createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    AddEventScreen(),
    ProfileScreen(),
    MoreScreen(),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Skeletonizer(
        child: PageView(
          controller: _pageController,
          physics: ClampingScrollPhysics(),
          onPageChanged: (index) => setState(() => _currentIndex = index),
          children: _screens,
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onBottomNavTapped,
      ),
    );
  }
}
