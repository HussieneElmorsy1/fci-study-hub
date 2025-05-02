import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class AuthRemoteDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> loginWithEmail(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      log('AuthRemoteDataSource - loginWithEmail error: ${e.code}, ${e.message}');
      rethrow;
    } catch (e) {
      log('AuthRemoteDataSource - loginWithEmail unexpected error: $e');
      rethrow;
    }
  }

  Future<User?> loginWithMicrosoft() async {
    try {
      log('AuthRemoteDataSource - Starting Microsoft sign-in...');
      final microsoftProvider = OAuthProvider('microsoft.com');
      microsoftProvider.setCustomParameters({
        "prompt": "consent",
        'tenant': '5d3edc64-3c81-4c40-89c6-d3f5e1095f71', // تأكد إن الـ tenant ID صحيح
      });
      microsoftProvider.addScope('openid profile email');

      // التأكد من إن الطلب يتبعت كـ POST
      log('AuthRemoteDataSource - Attempting signInWithProvider...');
      final userCredential = await _auth.signInWithProvider(microsoftProvider);
      final user = userCredential.user;

      if (user != null) {
        log('AuthRemoteDataSource - Microsoft sign-in successful. User: ${user.email}, UID: ${user.uid}');
      } else {
        log('AuthRemoteDataSource - Microsoft sign-in failed: user is null');
      }
      return user;
    } on FirebaseAuthException catch (e) {
      log('AuthRemoteDataSource - loginWithMicrosoft FirebaseAuthException: ${e.code}, ${e.message}');
      if (e.code == 'unknown' && e.message?.contains('AADSTS900561') == true) {
        throw FirebaseAuthException(
          code: 'invalid-request-method',
          message: 'The Microsoft endpoint only accepts POST requests. Received a GET request.',
        );
      }
      rethrow;
    } on PlatformException catch (e) {
      log('AuthRemoteDataSource - loginWithMicrosoft PlatformException: ${e.code}, ${e.message}');
      rethrow;
    } catch (e) {
      log('AuthRemoteDataSource - loginWithMicrosoft unexpected error: $e');
      rethrow;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Stream<User?> authStateChanges() {
    return _auth.authStateChanges();
  }
}