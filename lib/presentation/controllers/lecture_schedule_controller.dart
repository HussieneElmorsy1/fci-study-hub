// lib/presentation/controllers/lecture_schedule_controller.dart
import 'dart:developer';
import 'package:get/get.dart';
import 'package:fci_app_new/data/models/lecture_time_model.dart'; //
import 'package:fci_app_new/domain/usecases/get_all_lecture_times_use_case.dart'; //
import 'package:dio/dio.dart'; //

class LectureScheduleController extends GetxController {
  final GetAllLectureTimesUseCase _getAllLectureTimesUseCase; //

  final RxList<LectureTimeModel> lectureTimes = <LectureTimeModel>[].obs; //
  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;

  LectureScheduleController(this._getAllLectureTimesUseCase); //

  @override
  void onInit() {
    super.onInit();
    fetchLectureTimes();
  }

  Future<void> fetchLectureTimes() async {
    isLoading(true);
    errorMessage('');
    try {
      final fetchedTimes = await _getAllLectureTimesUseCase.call(); // جلب البيانات باستخدام الـ Use Case
      lectureTimes.assignAll(fetchedTimes); // تحديث القائمة المراقبة
    } on DioException catch (e) { //
      errorMessage('خطأ في الشبكة/الـ API: ${e.message}'.tr);
      log('DioException in LectureScheduleController: $e');
    } catch (e) {
      errorMessage('حدث خطأ غير متوقع: ${e.toString()}'.tr);
      log('Unhandled error in LectureScheduleController: $e');
    } finally {
      isLoading(false);
    }
  }

  // يمكن إضافة دوال أخرى هنا للتعامل مع الفلاتر أو البحث إذا أردت
}