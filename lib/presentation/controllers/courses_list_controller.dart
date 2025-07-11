// lib/presentation/controllers/courses_list_controller.dart
import 'dart:developer';
import 'package:get/get.dart';
import 'package:fci_app_new/data/models/course_model.dart'; //
import 'package:fci_app_new/domain/usecases/get_courses_by_major_use_case.dart'; //
import 'package:dio/dio.dart'; //

class CoursesListController extends GetxController {
  final GetCoursesByMajorUseCase _getCoursesByMajorUseCase; //

  final RxList<CourseModel> courses = <CourseModel>[].obs; //
  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;
  final RxString majorId = ''.obs; // لتخزين الـ majorId الذي تم تمريره

  CoursesListController(this._getCoursesByMajorUseCase); //

  @override
  void onInit() {
    super.onInit();
    // الحصول على majorId من الـ arguments عند تهيئة المتحكم
    if (Get.arguments is Map && Get.arguments.containsKey('majorId')) { //
      majorId.value = Get.arguments['majorId'] as String; //
      fetchCourses(majorId.value);
    } else {
      errorMessage('Major ID not provided.');
      isLoading(false);
    }
  }

  Future<void> fetchCourses(String majorId) async {
    isLoading(true);
    errorMessage('');
    try {
      final fetchedCourses = await _getCoursesByMajorUseCase.call(majorId); //
      courses.assignAll(fetchedCourses); //
    } on DioException catch (e) { //
      errorMessage('خطأ في الشبكة/الـ API: ${e.message}'.tr);
      log('DioException in CoursesListController: $e');
    } catch (e) {
      errorMessage('حدث خطأ غير متوقع: ${e.toString()}'.tr);
      log('Unhandled error in CoursesListController: $e');
    } finally {
      isLoading(false);
    }
  }

  // يمكنك إضافة دوال أخرى هنا للتعامل مع الفلاتر (المستوى، التخصص الفرعي) أو البحث
}