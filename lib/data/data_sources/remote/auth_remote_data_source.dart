// lib/data/data_sources/remote/auth_remote_data_source.dart
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:fci_app_new/data/api/api_service.dart'; //
import 'package:shared_preferences/shared_preferences.dart';

class AuthRemoteDataSource {
  final ApiService _apiService; //

  AuthRemoteDataSource(this._apiService);

  Future<Map<String, dynamic>> loginUser(
      String email, String password, String role) async {
    String endpoint;
    if (role == 'user') {
      endpoint = 'auth/login-user'; //
    } else if (role == 'admin') {
      endpoint = 'auth/login-admin'; //
    } else {
      throw Exception('Invalid role specified for login.');
    }

    try {
      log('Attempting to login as $role with email: $email to endpoint: $endpoint');
      final response = await _apiService.post(
        endpoint,
        data: {
          'email': email,
          'password': password,
        },
      );

      log('Login response status: ${response.statusCode}');
      log('Login response data: ${response.data}');

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw ApiException(response.statusCode!, response.data.toString()); //
      }
    } on DioException catch (e) {
      log('DioException in loginUser: ${e.type} - ${e.message}');
      rethrow;
    } catch (e) {
      log('Unexpected error in loginUser: $e');
      throw Exception('Unexpected error: $e');
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('isLoggedIn');
    await prefs.remove('userEmail');
    await prefs.remove('userId');
    await prefs.remove('userRole');
    log('Local logout (token cleared) successful.');
  }

  // تم تعديل دالة resetPassword لترجع Future<bool>
  Future<bool> resetPassword(String email) async {
    try {
      final response = await _apiService.post(
        'auth/forgot-password', //
        data: {'email': email},
      );
      // افتراض أن API يرجع شيئًا يشير للنجاح في حالة 200
      return response.statusCode == 200 && (response.data['success'] == true || response.data['message'] != null);
    } catch (e) {
      log('Error in resetPassword: $e');
      return false;
    }
  }

  // تم تعديل اسم الدالة إلى verifyOtp (ليطابق الـ Repository) وترجع Future<bool>
  Future<bool> verifyOtp(String email, String otp) async {
    try {
      final response = await _apiService.post(
        'auth/verify-reset-code', //
        data: {'email': email, 'code': otp}, // اسم المفتاح في API هو 'code'
      );
      return response.statusCode == 200 && (response.data['success'] == true || response.data['message'] != null);
    } catch (e) {
      log('Error in verifyOtp: $e');
      return false;
    }
  }

  // تم تعديل اسم الدالة إلى createNewPassword (ليطابق الـ Repository) وترجع Future<bool>
  Future<bool> createNewPassword(String email, String newPassword) async {
    try {
      final response = await _apiService.post(
        'auth/reset-password', //
        data: {'email': email, 'newPassword': newPassword},
      );
      return response.statusCode == 200 && (response.data['success'] == true || response.data['message'] != null);
    } catch (e) {
      log('Error in createNewPassword: $e');
      return false;
    }
  }
}