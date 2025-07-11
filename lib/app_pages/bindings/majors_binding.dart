// lib/app_pages/bindings/majors_binding.dart
import 'package:fci_app_new/domain/repository/major_repository_impl.dart';
import 'package:get/get.dart';
import 'package:fci_app_new/data/api/api_service.dart'; //
import 'package:fci_app_new/data/datasources/remote/academic_remote_data_source.dart'; //
import 'package:fci_app_new/domain/repository/major_repository.dart'; //
import 'package:fci_app_new/domain/usecases/get_all_majors_use_case.dart'; //
import 'package:fci_app_new/presentation/controllers/majors_controller.dart'; //

class MajorsBinding implements Bindings {
  @override
  void dependencies() {
    // تسجيل مصدر البيانات البعيد الأكاديمي
    Get.lazyPut<AcademicRemoteDataSource>(() => AcademicRemoteDataSource(Get.find<ApiService>())); //

    // تسجيل الـ Repository للتخصصات
    Get.lazyPut<MajorRepository>(() => MajorRepositoryImpl(Get.find<AcademicRemoteDataSource>())); //

    // تسجيل الـ Use Case لجلب جميع التخصصات
    Get.lazyPut<GetAllMajorsUseCase>(() => GetAllMajorsUseCase(Get.find<MajorRepository>())); //

    // تسجيل الـ Controller للتخصصات
    Get.lazyPut<MajorsController>(() => MajorsController(Get.find<GetAllMajorsUseCase>())); //
  }
}