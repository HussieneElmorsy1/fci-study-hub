// lib/data/data_sources/remote/lecture_remote_data_source.dart
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:fci_app_new/data/api/api_service.dart'; //
import 'package:fci_app_new/data/models/lecture_time_model.dart'; //

class LectureRemoteDataSource {
  final ApiService _apiService; //

  LectureRemoteDataSource(this._apiService);

  /// يجلب جميع مواعيد المحاضرات من الـ API
  Future<List<LectureTimeModel>> getAllLectureTimes() async {
    try {
      final response = await _apiService.get('/lecture-time'); //
      log('LectureRemoteDataSource: API Response for /lecture-time: ${response.statusCode}, Data: ${response.data}');

      if (response.statusCode == 200) {
        // **تم التعديل هنا:** الوصول إلى القائمة الفعلية عبر مفتاح 'data'
        final List<dynamic> lectureTimesJson = response.data['data']; // <--- هذا هو التعديل الأساسي

        // التأكد من أن القائمة ليست null قبل التحويل (اختياري، لكن يفضل)
        if (lectureTimesJson == null) {
          return []; // إرجاع قائمة فارغة إذا كانت البيانات null
        }

        return lectureTimesJson.map((json) => LectureTimeModel.fromJson(json)).toList(); //
      } else {
        throw ApiException(response.statusCode!, response.data.toString()); //
      }
    } on DioException catch (e) {
      log('DioException in LectureRemoteDataSource.getAllLectureTimes: $e');
      rethrow;
    } catch (e) {
      log('Error in LectureRemoteDataSource.getAllLectureTimes: $e');
      throw Exception('Failed to fetch lecture times: $e');
    }
  }

  // يمكن إضافة دوال أخرى هنا
}