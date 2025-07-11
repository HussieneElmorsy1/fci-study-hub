// lib/data/repositories/course_repository_impl.dart
import 'dart:developer';
import 'package:dio/dio.dart'; //
import 'package:fci_app_new/data/datasources/remote/academic_remote_data_source.dart'; //
import 'package:fci_app_new/data/models/course_model.dart'; //
import 'package:fci_app_new/domain/repository/course_repository.dart'; //

class CourseRepositoryImpl implements CourseRepository {
  final AcademicRemoteDataSource _remoteDataSource; //

  CourseRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<CourseModel>> getCoursesByMajorId(String majorId) async {
    try {
      return await _remoteDataSource.getCoursesByMajorId(majorId); //
    } on DioException catch (e) { //
      log('DioException in CourseRepositoryImpl.getCoursesByMajorId: $e');
      rethrow;
    } catch (e) {
      log('Error in CourseRepositoryImpl.getCoursesByMajorId: $e');
      throw Exception('Failed to get courses by major ID: $e');
    }
  }

  // يمكنك إضافة تطبيقات الدوال الأخرى هنا (مثال: getCourseById, createCourse)
}