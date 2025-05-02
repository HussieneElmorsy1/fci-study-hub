// address: lib/domain/repository/auth_repository_impl.dart
import 'package:fci_app_new/domain/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fci_app_new/data/data_sources/remote/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<User?> loginWithEmail(String email, String password) {
    return remoteDataSource.loginWithEmail(email, password);
  }

  @override
  Future<User?> loginWithMicrosoft() {
    return remoteDataSource.loginWithMicrosoft();
  }

  @override
  Future<void> logout() {
    return remoteDataSource.logout();
  }

  @override
  Stream<User?> authStateChanges() {
    return remoteDataSource.authStateChanges();
  }
}