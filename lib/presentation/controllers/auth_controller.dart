// lib/presentation/controllers/auth_controller.dart
import 'dart:developer';
import 'package:fci_app_new/domain/repository/auth_repository.dart'; //
import 'package:fci_app_new/domain/usecases/login_user.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart'; // لإدارة التخزين المحلي

class AuthController extends GetxController {
  final LoginUser _loginUser; //
  final AuthRepository _authRepository; //

  final Rxn<Map<String, dynamic>> currentUser = Rxn<Map<String, dynamic>>();
  final RxBool isLoading = false.obs;

  AuthController(this._loginUser, this._authRepository);

  @override
  void onInit() {
    super.onInit();
    _loadCurrentUserFromLocal();
  }

  Future<void> _loadCurrentUserFromLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null && token.isNotEmpty) {
      // هنا يجب أن نحصل على البيانات من الـ Repository الذي يجلبها من SharedPreferences
      final user = await _authRepository.getCurrentUser(); //
      if (user != null && user['email'] != null) {
        currentUser.value = user;
        log('AuthController: User loaded from local storage.');
      }
    }
  }

  // تم تعديل دالة login لتوقع قيمة منطقية (bool) من الـ Use Case
  Future<bool> login(String email, String password, String role) async { // تم إضافة role
    try {
      isLoading.value = true;
      // استدعاء الـ Use Case، وسيرجع true أو false
      final bool success = await _loginUser.call(email, password, role); //

      // إذا كان تسجيل الدخول ناجحاً، قم بتحميل بيانات المستخدم من الـ Repository (الذي يجلبها من SharedPreferences)
      if (success) {
        currentUser.value = await _authRepository.getCurrentUser(); //
        log('AuthController: User logged in and data loaded from repository.');
      } else {
        currentUser.value = null; // مسح المستخدم في حالة فشل تسجيل الدخول
      }
      return success; // إرجاع قيمة النجاح
    } catch (e) {
      log('AuthController: Login Error: $e');
      currentUser.value = null;
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // تم إزالة @override
  Future<void> logout() async {
    try {
      await _authRepository.logout(); //
      currentUser.value = null;
      log('AuthController: User logged out successfully.');
      // اختياري: توجيه المستخدم إلى شاشة تسجيل الدخول بعد تسجيل الخروج
      // Get.offAllNamed(AppRoutes.LOGIN_SCREEN);
    } catch (e) {
      log('AuthController: Error during logout: $e');
    }
  }

  bool get isLoggedIn => currentUser.value != null;
}