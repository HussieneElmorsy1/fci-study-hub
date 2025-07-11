// lib/domain/usecases/get_all_majors_use_case.dart
import 'dart:developer';
import 'package:dio/dio.dart'; //
import 'package:fci_app_new/data/models/major_model.dart'; //
import 'package:fci_app_new/domain/repository/major_repository.dart'; //

class GetAllMajorsUseCase {
  final MajorRepository _repository; //

  GetAllMajorsUseCase(this._repository);

  /// يجلب جميع التخصصات (Majors)
  Future<List<MajorModel>> call() async {
    log('GetAllMajorsUseCase: Executing to get all majors.');
    try {
      return await _repository.getAllMajors(); //
    } on DioException catch (e) { //
      log('DioException in GetAllMajorsUseCase: $e');
      rethrow;
    } catch (e) {
      log('Error in GetAllMajorsUseCase: $e');
      throw Exception('Failed to get all majors: $e');
    }
  }
}