// lib/data/repositories/material_repository_impl.dart
import 'dart:developer';
import 'package:dio/dio.dart'; //
import 'package:fci_app_new/data/datasources/remote/material_remote_data_source.dart'; //
import 'package:fci_app_new/data/models/material_item_model.dart'; //
import 'package:fci_app_new/domain/repository/material_repository.dart'; //

class MaterialRepositoryImpl implements MaterialRepository {
  final MaterialRemoteDataSource _remoteDataSource; //

  MaterialRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<MaterialItemModel>> getMaterialsByCourseAndType(String courseId, String materialType) async {
    try {
      return await _remoteDataSource.getMaterialsByCourseAndType(courseId, materialType); //
    } on DioException catch (e) { //
      log('DioException in MaterialRepositoryImpl.getMaterialsByCourseAndType: $e');
      rethrow;
    } catch (e) {
      log('Error in MaterialRepositoryImpl.getMaterialsByCourseAndType: $e');
      throw Exception('Failed to get materials by course and type: $e');
    }
  }

  // يمكن إضافة تطبيقات الدوال الأخرى هنا (إضافة، تعديل، حذف)
}