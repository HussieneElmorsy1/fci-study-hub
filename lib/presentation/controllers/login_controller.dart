import 'package:fci_app_new/app_pages/app_routes.dart';
import 'package:fci_app_new/data/services/auth_service.dart';
import 'package:fci_app_new/domain/repository/auth_repository.dart';
import 'package:fci_app_new/domain/use_case/sign_in_with_microsoft.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final isLoading = false.obs;
  final email = ''.obs;
  final password = ''.obs;
  final textColor = Colors.black.obs;
  final isPasswordVisible = false.obs;
  final AuthService _authService = Get.find();
  late final SignInWithMicrosoft _signInWithMicrosoft;

  @override
  void onInit() {
    super.onInit();
    _signInWithMicrosoft = SignInWithMicrosoft(Get.find<AuthRepository>());
  }

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      try {
        final user = await _authService.login(email.value, password.value);
        if (user != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', true);
          await prefs.setString('userEmail', user.email ?? '');
          await prefs.setString('userId', user.uid);
          developer.log('LoginController - Saved to SharedPreferences: isLoggedIn=true, userEmail=${user.email}, userId=${user.uid}');

          Get.offAllNamed(AppRoutes.MAIN_HOME_SCREEN);
          developer.log('LoginController - Navigated to MainHomeScreen');
        } else {
          Get.snackbar('Error', 'Failed to sign in. Please check your credentials.');
          developer.log('LoginController - Login failed: user is null');
        }
      } on FirebaseAuthException catch (e) {
        String errorMessage;
        switch (e.code) {
          case 'user-not-found':
            errorMessage = 'No user found for that email.';
            break;
          case 'wrong-password':
            errorMessage = 'Wrong password provided.';
            break;
          case 'invalid-email':
            errorMessage = 'The email address is badly formatted.';
            break;
          case 'user-disabled':
            errorMessage = 'This user account has been disabled.';
            break;
          default:
            errorMessage = 'An error occurred: ${e.message}';
        }
        Get.snackbar('Login Error', errorMessage);
        developer.log('LoginController - FirebaseAuthException: $errorMessage');
      } catch (e) {
        Get.snackbar('Error', 'An unexpected error occurred: ${e.toString()}');
        developer.log('LoginController - Unexpected error: $e');
      } finally {
        isLoading.value = false;
        developer.log('LoginController - isLoading set to false');
      }
    }
  }

  void navigateToForgotPassword() {
    Get.toNamed(AppRoutes.FORGOT_PASSWORD);
  }

  Future<void> signInWithMicrosoft() async {
    try {
      isLoading.value = true;
      developer.log('LoginController - Attempting to sign in with Microsoft...');
      final user = await _signInWithMicrosoft();
      if (user != null) {
        developer.log('LoginController - Microsoft sign-in successful. User: ${user.email}, UID: ${user.uid}');
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('userEmail', user.email ?? '');
        await prefs.setString('userId', user.uid);
        developer.log('LoginController - Saved to SharedPreferences: isLoggedIn=true, userEmail=${user.email}, userId=${user.uid}');

        Get.offAllNamed(AppRoutes.MAIN_HOME_SCREEN);
        developer.log('LoginController - Navigated to MainHomeScreen');
      } else {
        Get.snackbar('Error', 'Failed to sign in with Microsoft. Please try again.');
        developer.log('LoginController - Microsoft sign-in failed: user is null');
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'account-exists-with-different-credential':
          errorMessage = 'An account already exists with a different credential.';
          break;
        case 'invalid-credential':
          errorMessage = 'Invalid credentials provided.';
          break;
        case 'user-disabled':
          errorMessage = 'This user account has been disabled.';
          break;
        case 'operation-not-allowed':
          errorMessage = 'Microsoft sign-in is not enabled.';
          break;
        case 'invalid-email':
          errorMessage = 'The email address is badly formatted.';
          break;
        case 'user-not-found':
          errorMessage = 'No user found for that email.';
          break;
        case 'wrong-password':
          errorMessage = 'Wrong password provided.';
          break;
        case 'credential-already-in-use':
          errorMessage = 'This credential is already associated with a different user account.';
          break;
        case 'network-request-failed':
          errorMessage = 'Network error. Please check your internet connection.';
          break;
        case 'invalid-request-method':
          errorMessage = 'The Microsoft endpoint only accepts POST requests. Please check your Microsoft Azure configuration.';
          break;
        default:
          errorMessage = 'An error occurred: ${e.message}';
      }
      Get.snackbar('Microsoft Sign-In Error', errorMessage, duration: const Duration(seconds: 5));
      developer.log('LoginController - FirebaseAuthException: $errorMessage');
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred: ${e.toString()}', duration: const Duration(seconds: 5));
      developer.log('LoginController - Unexpected error: $e');
    } finally {
      isLoading.value = false;
      developer.log('LoginController - isLoading set to false');
    }
  }
}