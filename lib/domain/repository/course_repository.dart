// lib/domain/repository/course_repository.dart
import 'package:fci_app_new/data/models/course_model.dart'; //

abstract class CourseRepository {
  Future<List<CourseModel>> getCoursesByMajorId(String majorId);
  // يمكنك إضافة دوال مجردة أخرى هنا إذا احتجت (مثال: getCourseById, createCourse)
  // Future<CourseModel> getCourseById(String id);
  // Future<CourseModel> createCourse(CourseModel course);
}