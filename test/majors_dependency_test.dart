// Test for Majors dependency injection
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fci_app_new/data/api/api_service.dart';
import 'package:fci_app_new/data/datasources/remote/academic_remote_data_source.dart';
import 'package:fci_app_new/domain/repository/major_repository.dart';
import 'package:fci_app_new/domain/repository/major_repository_impl.dart';
import 'package:fci_app_new/domain/usecases/get_all_majors_use_case.dart';
import 'package:fci_app_new/presentation/controllers/majors_controller.dart';

void main() {
  group('Majors Dependency Injection Tests', () {
    setUp(() {
      // Reset GetX before each test
      Get.reset();
      
      // Initialize SharedPreferences for testing
      SharedPreferences.setMockInitialValues({});
    });

    tearDown(() {
      // Clean up after each test
      Get.reset();
    });

    test('Should register all majors dependencies correctly', () {
      // Register dependencies in the correct order
      Get.lazyPut<ApiService>(() => ApiService());
      Get.lazyPut<AcademicRemoteDataSource>(
          () => AcademicRemoteDataSource(Get.find<ApiService>()));
      Get.lazyPut<MajorRepository>(
          () => MajorRepositoryImpl(Get.find<AcademicRemoteDataSource>()));
      Get.lazyPut<GetAllMajorsUseCase>(
          () => GetAllMajorsUseCase(Get.find<MajorRepository>()));
      Get.lazyPut<MajorsController>(
          () => MajorsController(Get.find<GetAllMajorsUseCase>()));

      // Test that all dependencies can be resolved
      expect(() => Get.find<ApiService>(), returnsNormally);
      expect(() => Get.find<AcademicRemoteDataSource>(), returnsNormally);
      expect(() => Get.find<MajorRepository>(), returnsNormally);
      expect(() => Get.find<GetAllMajorsUseCase>(), returnsNormally);
      expect(() => Get.find<MajorsController>(), returnsNormally);
    });

    test('Should create MajorsController with proper dependencies', () {
      // Register dependencies
      Get.lazyPut<ApiService>(() => ApiService());
      Get.lazyPut<AcademicRemoteDataSource>(
          () => AcademicRemoteDataSource(Get.find<ApiService>()));
      Get.lazyPut<MajorRepository>(
          () => MajorRepositoryImpl(Get.find<AcademicRemoteDataSource>()));
      Get.lazyPut<GetAllMajorsUseCase>(
          () => GetAllMajorsUseCase(Get.find<MajorRepository>()));
      Get.lazyPut<MajorsController>(
          () => MajorsController(Get.find<GetAllMajorsUseCase>()));

      // Get the controller
      final controller = Get.find<MajorsController>();

      // Verify controller is created and has initial state
      expect(controller, isNotNull);
      expect(controller.majors, isNotNull);
      expect(controller.isLoading, isNotNull);
      expect(controller.errorMessage, isNotNull);
    });

    test('Should fail when trying to get MajorsController without dependencies', () {
      // Try to get controller without registering dependencies
      expect(() => Get.find<MajorsController>(), throwsA(isA<String>()));
    });
  });
}
