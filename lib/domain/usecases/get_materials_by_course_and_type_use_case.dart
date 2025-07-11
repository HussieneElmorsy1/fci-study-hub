// lib/domain/usecases/get_materials_by_course_and_type_use_case.dart
import 'dart:developer';
import 'package:dio/dio.dart'; //
import 'package:fci_app_new/data/models/material_item_model.dart'; //
import 'package:fci_app_new/domain/repository/material_repository.dart'; //

class GetMaterialsByCourseAndTypeUseCase {
  final MaterialRepository _repository; //

  GetMaterialsByCourseAndTypeUseCase(this._repository);

  /// يجلب قائمة بالمواد (PDFs, Videos, Exams, Books) لمقرر دراسي معين ونوع معين.
  Future<List<MaterialItemModel>> call(String courseId, String materialType) async {
    log('GetMaterialsByCourseAndTypeUseCase: Executing to get $materialType for course $courseId.');
    try {
      return await _repository.getMaterialsByCourseAndType(courseId, materialType); //
    } on DioException catch (e) { //
      log('DioException in GetMaterialsByCourseAndTypeUseCase: $e');
      rethrow;
    } catch (e) {
      log('Error in GetMaterialsByCourseAndTypeUseCase: $e');
      throw Exception('Failed to get materials by course and type: $e');
    }
  }
}