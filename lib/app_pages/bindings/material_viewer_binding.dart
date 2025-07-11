// lib/app_pages/bindings/material_viewer_binding.dart
import 'package:fci_app_new/domain/repository/material_repository_impl.dart';
import 'package:get/get.dart';
import 'package:fci_app_new/data/api/api_service.dart'; //
import 'package:fci_app_new/data/datasources/remote/material_remote_data_source.dart'; //
import 'package:fci_app_new/domain/repository/material_repository.dart'; //
import 'package:fci_app_new/domain/usecases/get_materials_by_course_and_type_use_case.dart'; //
import 'package:fci_app_new/presentation/controllers/material_viewer_controller.dart'; //
import 'package:fci_app_new/domain/repository/auth_repository.dart'; //
import 'package:fci_app_new/data/datasources/remote/auth_remote_data_source.dart'; //
import 'package:fci_app_new/domain/repository/auth_repository_impl.dart'; //


class MaterialViewerBinding implements Bindings {
  @override
  void dependencies() {
    // تسجيل مصدر البيانات البعيد للمواد
    Get.lazyPut<MaterialRemoteDataSource>(() => MaterialRemoteDataSource(Get.find<ApiService>())); //

    // تسجيل الـ Repository للمواد
    Get.lazyPut<MaterialRepository>(() => MaterialRepositoryImpl(Get.find<MaterialRemoteDataSource>())); //

    // تسجيل الـ Use Case لجلب المواد
    Get.lazyPut<GetMaterialsByCourseAndTypeUseCase>(() => GetMaterialsByCourseAndTypeUseCase(Get.find<MaterialRepository>())); //

    // تسجيل AuthRepository إذا لم يكن مسجلاً عالمياً بالفعل (عادةً ما يكون مسجلاً)
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(Get.find<AuthRemoteDataSource>())); //
    // تسجيل الـ Controller للمواد
    Get.lazyPut<MaterialViewerController>(() => MaterialViewerController(Get.find<GetMaterialsByCourseAndTypeUseCase>(), Get.find<AuthRepository>())); //
  }
}