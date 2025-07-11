// lib/domain/usecases/get_all_lecture_times_use_case.dart
import 'dart:developer';
import 'package:fci_app_new/data/models/lecture_time_model.dart'; //
import 'package:fci_app_new/domain/repository/lecture_repository.dart'; //
import 'package:dio/dio.dart'; //

class GetAllLectureTimesUseCase {
  final LectureRepository _repository; //

  GetAllLectureTimesUseCase(this._repository);

  /// يجلب جميع مواعيد المحاضرات
  Future<List<LectureTimeModel>> call() async {
    log('GetAllLectureTimesUseCase: Executing to get all lecture times.');
    try {
      return await _repository.getAllLectureTimes(); //
    } on DioException catch (e) { //
      log('DioException in GetAllLectureTimesUseCase: $e');
      rethrow;
    } catch (e) {
      log('Error in GetAllLectureTimesUseCase: $e');
      throw Exception('Failed to get all lecture times: $e');
    }
  }
}