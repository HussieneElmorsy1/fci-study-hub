// lib/domain/repository/auth_repository_impl.dart
import 'package:fci_app_new/data/data_sources/remote/auth_remote_data_source.dart'; //
import 'package:fci_app_new/domain/repository/auth_repository.dart'; //
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource; //

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<bool> loginWithEmail(String email, String password, String role) async {
    try {
      final response = await _remoteDataSource.loginUser(email, password, role); //
      if (response['token'] != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', response['token']);
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('userEmail', email);
        await prefs.setString('userRole', role);
        return true;
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('isLoggedIn');
    await prefs.remove('userEmail');
    await prefs.remove('userRole');
  }

  @override
  // هنا ستتلقى قيمة bool مباشرة من _remoteDataSource.resetPassword
  Future<bool> resetPassword(String email) async {
    return await _remoteDataSource.resetPassword(email); //
  }

  @override
  // هنا ستتلقى قيمة bool مباشرة من _remoteDataSource.verifyOtp
  Future<bool> verifyOtp(String email, String otp) async {
    return await _remoteDataSource.verifyOtp(email, otp); //
  }

  @override
  // هنا ستتلقى قيمة bool مباشرة من _remoteDataSource.createNewPassword
  Future<bool> createNewPassword(String email, String newPassword) async {
    return await _remoteDataSource.createNewPassword(email, newPassword); //
  }

  @override
  Future<Map<String, dynamic>> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('userEmail');
    final role = prefs.getString('userRole');
    return {
      'email': email,
      'role': role,
    };
  }

  @override
  Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  @override
  Future<String?> getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userRole');
  }
}