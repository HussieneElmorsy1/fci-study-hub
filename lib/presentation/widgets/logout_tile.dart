import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fci_app_new/data/services/auth_service.dart';
import '../../app_pages/app_routes.dart';

class LogoutTile extends StatelessWidget {
  const LogoutTile({super.key});

  Future<void> _showLogoutDialog(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('6.6'.tr),
        content: Text('6.7'.tr),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text('6.8'.tr),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: Text('6.9'.tr),
          ),
        ],
      ),
    );

    if (result == true) {
      final authService = Get.find<AuthService>();
      await authService.logout();
      Get.offAllNamed(AppRoutes.LOGIN);  // بعد الخروج، العودة إلى شاشة تسجيل الدخول
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('6.6'.tr),
      leading: const Icon(Icons.exit_to_app),
      onTap: () => _showLogoutDialog(context),  // عند الضغط على "تسجيل الخروج"
    );
  }
}
