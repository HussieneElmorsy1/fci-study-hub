// lib/domain/repository/auth_repository.dart
abstract class AuthRepository {
  // تحديث دالة loginWithEmail لقبول الدور
  Future<bool> loginWithEmail(String email, String password, String role);
  Future<void> logout();
  Future<bool> resetPassword(String email);
  Future<bool> verifyOtp(String email, String otp);
  Future<bool> createNewPassword(String email, String newPassword);
  Future<Map<String, dynamic>> getCurrentUser();
  Future<String?> getAuthToken();
  Future<String?> getUserRole(); // دالة جديدة للحصول على الدور المخزن
}