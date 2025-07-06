// lib/domain/usecases/login_user.dart
import 'dart:developer'; //
import 'package:fci_app_new/domain/repository/auth_repository.dart'; //

class LoginUser {
  final AuthRepository _repository; //

  LoginUser(this._repository);

  // تم تعديل دالة call لقبول معامل 'role' وتغيير نوع الإرجاع إلى Future<bool>
  Future<bool> call(String email, String password, String role) async {
    log('LoginUser Use Case: Executing login for $email with role: $role');
    try {
      // تمرير الدور إلى دالة loginWithEmail في الـ Repository
      final bool success = await _repository.loginWithEmail(email, password, role); //
      // هنا يمكنك إضافة أي منطق أعمال إضافي قبل إرجاع الاستجابة،
      // مثل التحقق من قواعد عمل معينة بعد تسجيل الدخول.
      return success; // إرجاع القيمة المنطقية (true/false) من الـ Repository
    } catch (e) {
      log('LoginUser Use Case: Error during login: $e');
      rethrow; // إعادة إلقاء الخطأ للتعامل معه في الـ Controller
    }
  }
}