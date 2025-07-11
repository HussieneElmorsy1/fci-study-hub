// lib/presentation/screens/role_selection_screen.dart
import 'package:fci_app_new/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fci_app_new/app_pages/app_routes.dart'; //
import 'package:flutter_svg/flutter_svg.dart'; //

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white, //
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLogo(),
              const SizedBox(height: 30),
              _buildTitle(),
              const SizedBox(height: 10),
              _buildSubtitle(),
              const SizedBox(height: 100),
              _buildRoleButton(
                context,
                text: 'الدخول كطالب'.tr,
                role: 'user', // الدور المقابل لـ auth/login-user
                onPressed: () {
                  Get.toNamed(AppRoutes.LOGIN, arguments: 'user'); //
                },
              ),
              const SizedBox(height: 20),
              _buildRoleButton(
                context,
                text: 'الدخول كمدرس'.tr,
                role: 'admin', // الدور المقابل لـ auth/login-admin
                onPressed: () {
                  Get.toNamed(AppRoutes.LOGIN, arguments: 'admin'); //
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return SvgPicture.asset(
      'assets/images/login_screen/Vector.svg', // تأكد من وجود المسار الصحيح لشعارك
      height: 150,
      width: 150,
    );
  }

  Widget _buildTitle() {
    return Column(
      children: [
        Text('التعليم العالي في مصر'.tr, style: AppTextStyles.headline1), //
        const SizedBox(height: 5),
        Text('جامعة قناة السويس'.tr,
            style:
                AppTextStyles.bodyText.copyWith(color: AppColors.primary)), //
        Text('كلية الحاسبات والمعلومات'.tr,
            style:
                AppTextStyles.bodyText.copyWith(color: AppColors.primary)), //
      ],
    );
  }

  Widget _buildSubtitle() {
    return Text(
      'اختر دورك لتسجيل الدخول'.tr, // يمكنك تعديل هذه الرسالة
      style: AppTextStyles.bodyText, //
      textAlign: TextAlign.center,
    );
  }

  Widget _buildRoleButton(BuildContext context,
      {required String text,
      required String role,
      required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary, //
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        minimumSize: Size(Get.width * 0.7, 50), // جعل الزر عرضياً أكثر
      ),
      child: Text(
        text,
        style: AppTextStyles.bodyText.copyWith(color: AppColors.secondary), //
      ),
    );
  }
}
