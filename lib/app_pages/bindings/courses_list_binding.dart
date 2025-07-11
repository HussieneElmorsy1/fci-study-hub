// lib/app_pages/bindings/courses_list_binding.dart
import 'package:fci_app_new/domain/repository/course_repository_impl.dart';
import 'package:get/get.dart';
import 'package:fci_app_new/data/api/api_service.dart'; //
import 'package:fci_app_new/data/datasources/remote/academic_remote_data_source.dart'; //
import 'package:fci_app_new/domain/repository/course_repository.dart'; //
import 'package:fci_app_new/domain/usecases/get_courses_by_major_use_case.dart'; //
import 'package:fci_app_new/presentation/controllers/courses_list_controller.dart'; //

class CoursesListBinding implements Bindings {
  @override
  void dependencies() {
    // تسجيل مصدر البيانات البعيد الأكاديمي إذا لم يكن مسجلاً عالمياً بعد
    // Get.lazyPut<AcademicRemoteDataSource>(() => AcademicRemoteDataSource(Get.find<ApiService>())); // إذا لم يكن مسجلاً بالفعل في MajorsBinding

    // تسجيل الـ Repository للمقررات
    Get.lazyPut<CourseRepository>(() => CourseRepositoryImpl(Get.find<AcademicRemoteDataSource>())); //

    // تسجيل الـ Use Case لجلب المقررات
    Get.lazyPut<GetCoursesByMajorUseCase>(() => GetCoursesByMajorUseCase(Get.find<CourseRepository>())); //

    // تسجيل الـ Controller للمقررات
    Get.lazyPut<CoursesListController>(() => CoursesListController(Get.find<GetCoursesByMajorUseCase>())); //
  }
}