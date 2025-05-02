import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fci_app_new/core/utils/string_utils.dart';
import 'package:fci_app_new/data/models/profile_model.dart';
import 'package:fci_app_new/domain/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInWithMicrosoft {
  final AuthRepository repository;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  SignInWithMicrosoft(this.repository);

  Future<User?> call() async {
    try {
      log('SignInWithMicrosoft - Calling repository.loginWithMicrosoft...');
      final user = await repository.loginWithMicrosoft();
      if (user != null) {
        log('SignInWithMicrosoft - User logged in: ${user.email}, UID: ${user.uid}');

        // حفظ بيانات الطالب في مجموعة students
        final studentId = extractStudentId(user.email ?? '');
        final student = ProfileModel(
          name: user.displayName,
          email: user.email,
          studentId: studentId,
        );

        log('SignInWithMicrosoft - Saving student data to Firestore...');
        await _firestore
            .collection('students')
            .doc(user.uid)
            .set(student.toJson(), SetOptions(merge: true));
        log('SignInWithMicrosoft - Student data saved to Firestore');

        // حفظ بيانات المستخدم في مجموعة users
        log('SignInWithMicrosoft - Saving user data to Firestore...');
        await _firestore.collection('users').doc(user.uid).set({
          'name': user.displayName ?? user.email?.split('@')[0] ?? 'مستخدم',
          'photoUrl': user.photoURL ?? '',
          'isOnline': true,
          'lastSeen': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
        log('SignInWithMicrosoft - User data saved to Firestore');
      }
      return user;
    } on FirebaseAuthException catch (e) {
      log('SignInWithMicrosoft - FirebaseAuthException: ${e.code}, ${e.message}');
      rethrow;
    } catch (e) {
      log('SignInWithMicrosoft - Unexpected error: $e');
      rethrow;
    }
  }
}