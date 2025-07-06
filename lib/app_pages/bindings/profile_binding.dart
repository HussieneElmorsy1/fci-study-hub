// lib/app_pages/bindings/profile_binding.dart
import 'package:fci_app_new/domain/repository/profile_repository_impl.dart';
import 'package:get/get.dart';
import 'package:fci_app_new/data/api/api_service.dart'; //
import 'package:fci_app_new/data/data_sources/remote/auth_remote_data_source.dart'; //
import 'package:fci_app_new/domain/repository/auth_repository.dart'; //
import 'package:fci_app_new/domain/repository/auth_repository_impl.dart'; //
import 'package:fci_app_new/domain/repository/profile_repository.dart'; //
import 'package:fci_app_new/presentation/controllers/profile_controller.dart'; //

class ProfileBinding implements Bindings {
  @override
  void dependencies() {
    // Register required dependencies if not already registered
    if (!Get.isRegistered<ApiService>()) {
      Get.lazyPut<ApiService>(() => ApiService());
    }

    if (!Get.isRegistered<AuthRemoteDataSource>()) {
      Get.lazyPut<AuthRemoteDataSource>(
          () => AuthRemoteDataSource(Get.find<ApiService>()));
    }

    if (!Get.isRegistered<AuthRepository>()) {
      Get.lazyPut<AuthRepository>(
          () => AuthRepositoryImpl(Get.find<AuthRemoteDataSource>()));
    }

    if (!Get.isRegistered<ProfileRepository>()) {
      Get.lazyPut<ProfileRepository>(
          () => ProfileRepositoryImpl(Get.find<ApiService>()));
    }

    Get.lazyPut<ProfileController>(() => ProfileController(
        Get.find<ProfileRepository>(), Get.find<AuthRepository>()));
  }
}
