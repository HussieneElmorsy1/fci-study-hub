// lib/features/settings/presentation/screens/more_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_pages/app_routes.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/dark_mode_setting_tile.dart';
import '../widgets/logout_tile.dart';
import '../widgets/notifications_setting_tile.dart';
import '../widgets/settings_section_header.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  int _currentIndex = 3;

  void _onBottomNavTapped(int index) {
    setState(() {
      _currentIndex = index; // Update the current index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('6.1'.tr), // "المزيد
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_forward,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: () =>
              Get.toNamed(AppRoutes.HOME_SCREEN), // Navigate to the home screen
        ),
      ),
      body: const SettingsList(),
      extendBody: true,
    );
  }
}

class SettingsList extends StatelessWidget {
  const SettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SettingsSectionHeader(title: '6.2'.tr), // "الإعدادات العامة
        DarkModeSettingTile(),
        NotificationsSettingTile(),
        SettingsSectionDivider(),
        SettingsSectionHeader(title: '6.3'.tr), // "الحساب
        LogoutTile(),
      ],
    );
  }
}
