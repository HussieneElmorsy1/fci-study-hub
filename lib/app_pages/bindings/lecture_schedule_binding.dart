// lib/app_pages/bindings/lecture_schedule_binding.dart
import 'dart:developer'; // أضف هذا الاستيراد

import 'package:fci_app_new/data/datasources/remote/lecture_remote_data_source.dart';
import 'package:fci_app_new/domain/repository/lecture_repository_impl.dart';
import 'package:get/get.dart';
import 'package:fci_app_new/data/api/api_service.dart'; //
import 'package:fci_app_new/domain/repository/lecture_repository.dart'; //
import 'package:fci_app_new/domain/usecases/get_all_lecture_times_use_case.dart'; //
import 'package:fci_app_new/presentation/controllers/lecture_schedule_controller.dart'; //

class LectureScheduleBinding implements Bindings {
  @override
  void dependencies() {
    log('LectureScheduleBinding: dependencies() called!'); // <--- أضف هذا السطر

    // تسجيل ApiService إذا لم يتم تسجيله عالمياً (في main.dart)
    // Get.lazyPut<ApiService>(() => Get.find<ApiService>()); // يمكن استخدام Get.find إذا كان مسجلاً عالمياً

    // تسجيل مصدر البيانات البعيد للمحاضرات
    Get.lazyPut<LectureRemoteDataSource>(() => LectureRemoteDataSource(Get.find<ApiService>())); //

    // تسجيل الـ Repository للمحاضرات
    Get.lazyPut<LectureRepository>(() => LectureRepositoryImpl(Get.find<LectureRemoteDataSource>())); //

    // تسجيل الـ Use Case للمحاضرات
    Get.lazyPut<GetAllLectureTimesUseCase>(() => GetAllLectureTimesUseCase(Get.find<LectureRepository>())); //

    // تسجيل الـ Controller للمحاضرات
    Get.lazyPut<LectureScheduleController>(() => LectureScheduleController(Get.find<GetAllLectureTimesUseCase>())); //

    log('LectureScheduleBinding: dependencies() finished registration.'); // <--- أضف هذا السطر
  }
}