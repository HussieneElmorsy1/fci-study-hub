import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final bool enableHapticFeedback;

  CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.enableHapticFeedback = true,
  });

  final List<String> _labels = [
    '3.14'.tr, // 'الرئيسية',
    '3.15'.tr, // 'الجدول',
    '3.16'.tr, // 'الشخصية',
    '3.17'.tr, // 'المزيد',
  ];

  final List<Icon> _icon = [
    const Icon(Icons.home_outlined),
    const Icon(Icons.calendar_month_outlined),
    const Icon(Icons.person_outline),
    const Icon(Icons.more_horiz_outlined),
  ];

  void _onItemTapped(int index) {
    if (enableHapticFeedback) {
      HapticFeedback.lightImpact();
    }
    onTap(index); // هذا يكفي للتبديل بين الصفحات
    // تم إزالة Get.toNamed() تماماً
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: _onItemTapped,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      items: List.generate(_labels.length, (index) {
        return BottomNavigationBarItem(
          icon: _icon[index],
          label: _labels[index],
        );
      }),
    );
  }
}