// lib/data/datasources/remote/academic_remote_data_source.dart
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:fci_app_new/data/api/api_service.dart'; //
import 'package:fci_app_new/data/models/major_model.dart'; //
import 'package:fci_app_new/data/models/course_model.dart'; // استيراد CourseModel

class AcademicRemoteDataSource {
  final ApiService _apiService; //

  AcademicRemoteDataSource(this._apiService);

  /// يجلب جميع التخصصات (Majors) من الـ API
  Future<List<MajorModel>> getAllMajors() async {
    try {
      final response = await _apiService.get('/major'); //
      log('AcademicRemoteDataSource: API Response for /major: ${response.statusCode}, Data: ${response.data}');

      if (response.statusCode == 200) {
        final List<dynamic> majorsJson = response.data['majors']; // بناءً على الاستجابة الفعلية
        if (majorsJson == null) {
          return [];
        }
        return majorsJson.map((json) => MajorModel.fromJson(json)).toList(); //
      } else {
        throw ApiException(response.statusCode!, response.data.toString()); //
      }
    } on DioException catch (e) {
      log('DioException in AcademicRemoteDataSource.getAllMajors: $e');
      rethrow;
    } catch (e) {
      log('Error in AcademicRemoteDataSource.getAllMajors: $e');
      throw Exception('Failed to fetch all majors: $e');
    }
  }

  /// ينشئ تخصصاً (Major) جديداً في الـ API
  Future<MajorModel> createMajor(String title) async {
    try {
      final response = await _apiService.post(
        '/major', //
        data: {'title': title},
      );
      log('AcademicRemoteDataSource: API Response for Create Major: ${response.statusCode}, Data: ${response.data}');
      if (response.statusCode == 200) {
        return MajorModel.fromJson(response.data is Map && response.data.containsKey('data') ? response.data['data'] : response.data); //
      } else {
        throw ApiException(response.statusCode!, response.data.toString()); //
      }
    } on DioException catch (e) {
      log('DioException in AcademicRemoteDataSource.createMajor: $e');
      rethrow;
    } catch (e) {
      log('Error in AcademicRemoteDataSource.createMajor: $e');
      throw Exception('Failed to create major: $e');
    }
  }

  /// يجلب تخصصاً (Major) معيناً بالـ ID من الـ API
  Future<MajorModel> getMajorById(String id) async {
    try {
      final response = await _apiService.get('/major/$id'); //
      log('AcademicRemoteDataSource: API Response for Get Major By ID: ${response.statusCode}, Data: ${response.data}');
      if (response.statusCode == 200) {
        return MajorModel.fromJson(response.data is Map && response.data.containsKey('data') ? response.data['data'] : response.data); //
      } else {
        throw ApiException(response.statusCode!, response.data.toString()); //
      }
    } on DioException catch (e) {
      log('DioException in AcademicRemoteDataSource.getMajorById: $e');
      rethrow;
    } catch (e) {
      log('Error in AcademicRemoteDataSource.getMajorById: $e');
      throw Exception('Failed to get major by ID: $e');
    }
  }

  /// يجلب المقررات الدراسية (Courses) لتخصص معين من الـ API
  /// (نفترض أن API /course يدعم التصفية بواسطة majorId)
  Future<List<CourseModel>> getCoursesByMajorId(String majorId) async {
    try {
      // بناءً على وثائق الـ API، نقطة نهاية '/course' تجلب جميع المقررات.
      // نفترض هنا أنها تدعم query parameter للتصفية بواسطة majorId.
      final response = await _apiService.get(
        '/course',
        queryParameters: {'majorId': majorId}, // تمرير majorId كـ query parameter
      );
      log('AcademicRemoteDataSource: API Response for /course?majorId=$majorId: ${response.statusCode}, Data: ${response.data}');

      if (response.statusCode == 200) {
        // بناءً على الاستجابة الفعلية، قد تكون القائمة مباشرة أو داخل مفتاح 'data' أو 'courses'
        // لنتوقع بنية مشابهة لـ /major response (قائمة داخل مفتاح)
        final List<dynamic> coursesJson = response.data['courses'] ?? []; // افتراض أن القائمة تحت مفتاح 'courses'

        // إذا كانت القائمة فارغة أو null، أرجع قائمة فارغة
        if (coursesJson == null || coursesJson.isEmpty) {
          return [];
        }
        return coursesJson.map((json) => CourseModel.fromJson(json)).toList(); //
      } else {
        throw ApiException(response.statusCode!, response.data.toString()); //
      }
    } on DioException catch (e) {
      log('DioException in AcademicRemoteDataSource.getCoursesByMajorId: $e');
      rethrow;
    } catch (e) {
      log('Error in AcademicRemoteDataSource.getCoursesByMajorId: $e');
      throw Exception('Failed to fetch courses by major ID: $e');
    }
  }
}