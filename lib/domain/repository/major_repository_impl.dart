// lib/data/repositories/major_repository_impl.dart
import 'dart:developer';
import 'package:dio/dio.dart'; //
import 'package:fci_app_new/data/datasources/remote/academic_remote_data_source.dart'; //
import 'package:fci_app_new/data/models/major_model.dart'; //
import 'package:fci_app_new/domain/repository/major_repository.dart'; //

class MajorRepositoryImpl implements MajorRepository {
  final AcademicRemoteDataSource _remoteDataSource; //

  MajorRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<MajorModel>> getAllMajors() async {
    try {
      return await _remoteDataSource.getAllMajors(); //
    } on DioException catch (e) { //
      log('DioException in MajorRepositoryImpl.getAllMajors: $e');
      rethrow;
    } catch (e) {
      log('Error in MajorRepositoryImpl.getAllMajors: $e');
      throw Exception('Failed to get all majors: $e');
    }
  }

  @override
  Future<MajorModel> getMajorById(String id) async {
    try {
      return await _remoteDataSource.getMajorById(id); //
    } on DioException catch (e) { //
      log('DioException in MajorRepositoryImpl.getMajorById: $e');
      rethrow;
    } catch (e) {
      log('Error in MajorRepositoryImpl.getMajorById: $e');
      throw Exception('Failed to get major by ID: $e');
    }
  }

  @override
  Future<MajorModel> createMajor(String title) async {
    try {
      return await _remoteDataSource.createMajor(title); //
    } on DioException catch (e) { //
      log('DioException in MajorRepositoryImpl.createMajor: $e');
      rethrow;
    } catch (e) {
      log('Error in MajorRepositoryImpl.createMajor: $e');
      throw Exception('Failed to create major: $e');
    }
  }
}