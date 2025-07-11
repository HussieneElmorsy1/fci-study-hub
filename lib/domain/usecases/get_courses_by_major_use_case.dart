// lib/domain/usecases/get_courses_by_major_use_case.dart
import 'dart:developer';
import 'package:dio/dio.dart'; //
import 'package:fci_app_new/data/models/course_model.dart'; //
import 'package:fci_app_new/domain/repository/course_repository.dart'; //

class GetCoursesByMajorUseCase {
  final CourseRepository _repository; //

  GetCoursesByMajorUseCase(this._repository);

  /// يجلب جميع المقررات الدراسية لتخصص معين
  Future<List<CourseModel>> call(String majorId) async {
    log('GetCoursesByMajorUseCase: Executing to get courses for major ID: $majorId');
    try {
      return await _repository.getCoursesByMajorId(majorId); //
    } on DioException catch (e) { //
      log('DioException in GetCoursesByMajorUseCase: $e');
      rethrow;
    } catch (e) {
      log('Error in GetCoursesByMajorUseCase: $e');
      throw Exception('Failed to get courses by major ID: $e');
    }
  }
}