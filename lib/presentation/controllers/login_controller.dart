// lib/presentation/controllers/login_controller.dart
import 'package:fci_app_new/app_pages/app_routes.dart'; //
import 'package:fci_app_new/data/api/api_service.dart'; //
import 'package:fci_app_new/domain/usecases/login_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart'; // لم يعد مطلوبًا هنا لأن AuthRepositoryImpl يتعامل مع حفظ البيانات
import 'dart:developer' as developer;

// هذه الاستثناءات مُعرفة في lib/data/api/api_service.dart
import 'package:fci_app_new/data/api/api_service.dart'; //


class LoginController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RxBool isLoading = false.obs;
  final RxString email = ''.obs;
  final RxString password = ''.obs;
  final Rx<Color> textColor = Colors.black.obs;
  final RxBool isPasswordVisible = false.obs;

  final LoginUser _loginUser; //

  LoginController(this._loginUser);

  @override
  void onInit() {
    super.onInit();
  }

  // تم تعديل دالة login لقبول معامل 'role'
  Future<bool> login(String email, String password, String role) async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      try {
        // استدعاء الـ Use Case مع تمرير الدور
        final bool success = await _loginUser.call(email, password, role); //

        if (success) {
          // لم نعد نحتاج للوصول إلى userData['token'] هنا، لأن حفظ البيانات يتم في AuthRepositoryImpl
          developer.log('LoginController - Login successful, data saved by AuthRepositoryImpl.');
          // التوجيه إلى الشاشة الرئيسية سيتم في الواجهة (login_screen.dart) بعد استدعاء controller.login
          // أو يمكن إضافته هنا إذا كنت تفضل أن يتحكم المتحكم في التوجيه بعد النجاح
          // Get.offAllNamed(AppRoutes.MAIN_HOME_SCREEN);
          return true;
        } else {
          Get.snackbar('Error', 'Failed to sign in. Please check your credentials.');
          developer.log('LoginController - Login failed: Use Case returned false.');
          return false;
        }
      } catch (e) {
        String errorMessage = 'An unexpected error occurred: ${e.toString()}';
        // يتم التعامل مع هذه الاستثناءات المعرفة في lib/data/api/api_service.dart
        if (e is ApiException) { //
          errorMessage = 'API Error (${e.statusCode}): ${e.message}';
        } else if (e is NetworkException) { //
          errorMessage = 'Network Error: ${e.message}';
        } else if (e is UnauthorizedException) { //
          errorMessage = 'Authentication Error: ${e.message}';
        }
        Get.snackbar('Error', errorMessage, duration: const Duration(seconds: 5));
        developer.log('LoginController - Unexpected error: $e');
        return false;
      } finally {
        isLoading.value = false;
        developer.log('LoginController - isLoading set to false');
      }
    }
    return false; // في حالة فشل التحقق من صحة النموذج
  }

  void navigateToForgotPassword() {
    Get.toNamed(AppRoutes.FORGOT_PASSWORD); //
  }
}