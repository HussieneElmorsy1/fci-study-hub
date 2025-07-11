// lib/data/models/lecture_time_model.dart
import 'package:get/get.dart'; // For .tr() if used for default values

class LectureTimeModel {
  final String id;
  final String courseName;
  final String doctorName;
  final String rangeTime; // مثال: "10:00 صباحًا - 12:00 ظهرًا"

  LectureTimeModel({
    required this.id,
    required this.courseName,
    required this.doctorName,
    required this.rangeTime,
  });

  factory LectureTimeModel.fromJson(Map<String, dynamic> json) {
    return LectureTimeModel(
      id: json['id']?.toString() ?? '',
      courseName: json['courseName'] ?? 'اسم المادة غير معروف'.tr,
      doctorName: json['DoctorName'] ?? 'اسم الدكتور غير معروف'.tr, // لاحظ 'DoctorName' بحرف D كبير
      rangeTime: json['rangeTime'] ?? 'الوقت غير محدد'.tr,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'courseName': courseName,
      'DoctorName': doctorName,
      'rangeTime': rangeTime,
    };
  }
}