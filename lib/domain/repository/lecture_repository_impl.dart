// lib/domain/repository/lecture_repository_impl.dart
import 'package:fci_app_new/data/datasources/remote/lecture_remote_data_source.dart';
import 'package:fci_app_new/data/models/lecture_time_model.dart'; //
import 'package:fci_app_new/domain/repository/lecture_repository.dart'; //
import 'dart:developer';
import 'package:dio/dio.dart'; //

class LectureRepositoryImpl implements LectureRepository {
  final LectureRemoteDataSource _remoteDataSource; //

  LectureRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<LectureTimeModel>> getAllLectureTimes() async {
    try {
      return await _remoteDataSource.getAllLectureTimes(); //
    } on DioException catch (e) {
      //
      log('DioException in LectureRepositoryImpl.getAllLectureTimes: $e');
      rethrow;
    } catch (e) {
      log('Error in LectureRepositoryImpl.getAllLectureTimes: $e');
      throw Exception('Failed to fetch all lecture times: $e');
    }
  }

  // يمكن إضافة تطبيقات الدوال الأخرى هنا (جلب بالـ ID، إنشاء، تحديث، حذف)
}
