// address: lib/data/services/auth_service.dart
import 'package:fci_app_new/domain/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final AuthRepository _authRepository;

  AuthService(this._authRepository);

  Future<User?> login(String email, String password) {
    return _authRepository.loginWithEmail(email, password);
  }

  Future<User?> loginWithMicrosoft() {
    return _authRepository.loginWithMicrosoft();
  }

  Future<void> logout() async {
    await _authRepository.logout();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await prefs.remove('userEmail');
    await prefs.remove('userId');
  }

  Stream<User?> authStateChanges() {
    return _authRepository.authStateChanges();
  }
}