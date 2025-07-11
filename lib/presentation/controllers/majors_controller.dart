// lib/presentation/controllers/majors_controller.dart
import 'dart:developer';
import 'package:get/get.dart';
import 'package:fci_app_new/data/models/major_model.dart'; //
import 'package:fci_app_new/domain/usecases/get_all_majors_use_case.dart'; //
import 'package:dio/dio.dart'; //

class MajorsController extends GetxController {
  final GetAllMajorsUseCase _getAllMajorsUseCase; //

  final RxList<MajorModel> majors = <MajorModel>[].obs; //
  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;

  MajorsController(this._getAllMajorsUseCase); //

  @override
  void onInit() {
    super.onInit();
    fetchMajors();
  }

  Future<void> fetchMajors() async {
    isLoading(true);
    errorMessage('');
    try {
      final fetchedMajors = await _getAllMajorsUseCase.call(); // جلب البيانات باستخدام الـ Use Case
      majors.assignAll(fetchedMajors); // تحديث القائمة المراقبة
    } on DioException catch (e) { //
      errorMessage('خطأ في الشبكة/الـ API: ${e.message}'.tr);
      log('DioException in MajorsController: $e');
    } catch (e) {
      errorMessage('حدث خطأ غير متوقع: ${e.toString()}'.tr);
      log('Unhandled error in MajorsController: $e');
    } finally {
      isLoading(false);
    }
  }

  // يمكنك إضافة دوال أخرى هنا للتعامل مع منطق الشاشة
}
