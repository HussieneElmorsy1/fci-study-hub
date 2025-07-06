// lib/app_pages/bindings/auth_binding.dart
import 'package:fci_app_new/data/data_sources/remote/auth_remote_data_source.dart'; //
// تم تصحيح المسار ليتوافق مع مكان ملف LoginUser في مجلد 'auth'
import 'package:fci_app_new/domain/usecases/login_user.dart';
import 'package:get/get.dart';
import 'package:fci_app_new/data/api/api_service.dart'; //
import 'package:fci_app_new/domain/repository/auth_repository.dart'; //
import 'package:fci_app_new/domain/repository/auth_repository_impl.dart'; //
import 'package:fci_app_new/presentation/controllers/login_controller.dart'; //

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    // تسجيل ApiService (إذا لم يكن مسجلًا عالميًا بالفعل)
    Get.lazyPut<ApiService>(() => ApiService()); //

    // تسجيل مصدر البيانات البعيد
    Get.lazyPut<AuthRemoteDataSource>(() => AuthRemoteDataSource(Get.find<ApiService>())); //

    // تسجيل الـ Repository
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(Get.find<AuthRemoteDataSource>())); //

    // تسجيل الـ Use Case الجديد
    Get.lazyPut<LoginUser>(() => LoginUser(Get.find<AuthRepository>())); //

    // تسجيل الـ LoginController وحقن الـ Use Case فيه
    Get.lazyPut<LoginController>(() => LoginController(Get.find<LoginUser>())); //
  }
}