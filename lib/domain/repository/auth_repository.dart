// address: lib/domain/repository/auth_repository.dart
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<User?> loginWithEmail(String email, String password);
  Future<User?> loginWithMicrosoft();
  Future<void> logout();
  Stream<User?> authStateChanges();
}
//   Future<String?> getEmail();
//   Future<void> saveEmail(String email);
//   Future<void> deleteEmail();
//   bool isLoggedIn();
//   String getUserId();
//   String getUserName();
//   String getUserEmail();
//   String getUserPhotoUrl();
//   String getStudentId();
//   String getGender();
//   String getCollege();
//   String getUniversity();
//   String getLevel();
//   String getSpecialization();
//   String getDegree();
//   double getGPA();
// }