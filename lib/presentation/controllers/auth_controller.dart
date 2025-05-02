import 'package:firebase_auth/firebase_auth.dart';
import 'package:fci_app_new/data/services/auth_service.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final AuthService _authService;
  final Rxn<User> currentUser = Rxn<User>();
  final RxBool isLoading = false.obs;

  AuthController(this._authService);

  @override
  void onInit() {
    _setupAuthListener();
    super.onInit();
  }

  void _setupAuthListener() {
    _authService.authStateChanges().listen((user) {
      currentUser.value = user;
    });
  }

  Future<bool> login(String email, String password) async {
    try {
      isLoading.value = true;
      await _authService.login(email, password);
      return true;
    } catch (e) {
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await _authService.logout();
  }

  bool get isLoggedIn => currentUser.value != null;
}