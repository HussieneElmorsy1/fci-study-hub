// lib/data/repositories/profile_repository_impl.dart
import 'package:fci_app_new/data/api/api_service.dart'; //
import 'package:fci_app_new/data/models/profile_model.dart'; //
import 'package:fci_app_new/data/models/teacher_model.dart'; //
import 'package:fci_app_new/domain/repository/profile_repository.dart'; //
import 'package:dio/dio.dart'; //
import 'dart:developer'; //

class ProfileRepositoryImpl implements ProfileRepository {
  final ApiService _apiService; //

  ProfileRepositoryImpl(this._apiService);

  @override
  Future<ProfileModel> getStudentProfile() async {
    try {
      final response = await _apiService.get('/user/profile'); //
      log('ProfileRepositoryImpl - API Response for /user/profile: ${response.statusCode}, Data: ${response.data}');
      if (response.statusCode == 200) {
        return ProfileModel.fromJson(response.data); // ProfileModel.fromJson يتوقع 'userData'
      } else {
        throw ApiException(response.statusCode!, response.data.toString()); //
      }
    } on DioException catch (e) {
      log('DioException in ProfileRepositoryImpl (Student): $e');
      rethrow;
    } catch (e) {
      log('Error in ProfileRepositoryImpl (Student): $e');
      throw Exception('Failed to fetch student profile: $e');
    }
  }

  @override
  Future<TeacherModel> getTeacherProfile() async {
    try {
      final response = await _apiService.get('/user/admin/profile'); //
      log('ProfileRepositoryImpl - API Response for /user/admin/profile: ${response.statusCode}, Data: ${response.data}');
      if (response.statusCode == 200) {
        return TeacherModel.fromJson(response.data); // TeacherModel.fromJson يتوقع 'data'
      } else {
        throw ApiException(response.statusCode!, response.data.toString()); //
      }
    } on DioException catch (e) {
      log('DioException in ProfileRepositoryImpl (Teacher): $e');
      rethrow;
    } catch (e) {
      log('Error in ProfileRepositoryImpl (Teacher): $e');
      throw Exception('Failed to fetch teacher profile: $e');
    }
  }
}