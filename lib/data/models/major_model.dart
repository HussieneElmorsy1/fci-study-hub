// lib/data/models/major_model.dart
import 'package:get/get.dart'; // For .tr() if used for default values

class MajorModel {
  final String id;
  final String title; // اسم التخصص (مثال: "علوم الحاسب")

  MajorModel({
    required this.id,
    required this.title,
  });

  factory MajorModel.fromJson(Map<String, dynamic> json) {
    // بناءً على وثائق الـ API، نفترض أن الـ API يرجع قائمة مباشرة من الـ Majors
    // وكل عنصر في القائمة هو Map<String, dynamic> يحتوي على 'id' و 'title'
    return MajorModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? 'تخصص غير معروف'.tr,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
    };
  }
}