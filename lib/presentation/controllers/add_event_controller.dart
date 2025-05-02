import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fci_app_new/app_pages/app_routes.dart';

class AddEventController extends GetxController {
  final eventName = ''.obs;
  final eventDescription = ''.obs;
  final startDate = ''.obs;
  final endDate = ''.obs;

  Future<void> addEvent() async {
    if (eventName.value.isEmpty || startDate.value.isEmpty || endDate.value.isEmpty) {
      Get.snackbar('خطأ', 'يرجى ملء جميع الحقول المطلوبة');
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('events').add({
        'name': eventName.value,
        'description': eventDescription.value,
        'start_date': startDate.value,
        'end_date': endDate.value,
        'created_at': FieldValue.serverTimestamp(),
      });
      Get.snackbar('نجاح', 'تم إضافة الحدث بنجاح');
      await Future.delayed(const Duration(seconds: 1)); // انتظار ثانية عشان المستخدم يشوف الرسالة
      Get.offAllNamed(AppRoutes.MAIN_HOME_SCREEN);
    } catch (e) {
      Get.snackbar('خطأ', 'حدث خطأ أثناء إضافة الحدث: $e');
    }
  }
}