// lib/presentation/controllers/profile_controller.dart
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:fci_app_new/domain/repository/profile_repository.dart'; //
import 'package:fci_app_new/domain/repository/auth_repository.dart'; //
import 'package:fci_app_new/data/api/api_service.dart'; // For ApiException
import 'dart:developer';

class ProfileController extends GetxController {
  final ProfileRepository _profileRepository; //
  final AuthRepository _authRepository; //

  // متغير مراقب يمكن أن يحمل إما ProfileModel أو TeacherModel
  final Rxn<dynamic> userProfile = Rxn<dynamic>();

  RxBool isLoading = true.obs;
  RxString errorMessage = ''.obs;

  // Constructor - يتلقى التبعيات من GetX Binding
  ProfileController(this._profileRepository, this._authRepository);

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    isLoading(true);
    errorMessage('');
    try {
      final userRole = await _authRepository.getUserRole(); // جلب دور المستخدم

      if (userRole == 'user') {
        final studentProfile = await _profileRepository.getStudentProfile(); //
        userProfile.value = studentProfile;
      } else if (userRole == 'admin') {
        final teacherProfile = await _profileRepository.getTeacherProfile(); //
        userProfile.value = teacherProfile;
      } else {
        errorMessage('User role not found or invalid.');
        log('ProfileController: User role not found or invalid.');
      }
    } on DioException catch (e) {
      errorMessage('خطأ في الشبكة/الـ API: ${e.message}'.tr); //
      log('DioException in ProfileController: $e');
    } on ApiException catch (e) {
      errorMessage('خطأ في الـ API (${e.statusCode}): ${e.message}'.tr);
      log('ApiException in ProfileController: $e');
    } on NetworkException catch (e) {
      errorMessage('خطأ في الشبكة: ${e.message}'.tr);
      log('NetworkException in ProfileController: $e');
    } on UnauthorizedException catch (e) {
      errorMessage('خطأ في المصادقة: ${e.message}'.tr);
      log('UnauthorizedException in ProfileController: $e');
    } catch (e) {
      errorMessage('حدث خطأ غير متوقع: ${e.toString()}'.tr);
      log('Unhandled error in ProfileController: $e');
    } finally {
      isLoading(false);
    }
  }

  // يمكنك إضافة دوال أخرى هنا للتعامل مع تحديث الملف الشخصي
}
