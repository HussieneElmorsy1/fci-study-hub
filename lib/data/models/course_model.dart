// lib/data/models/course_model.dart
import 'package:get/get.dart'; // For .tr() if used for default values

class CourseModel {
  final String id;
  final String title; // اسم المقرر الدراسي (مثال: "الحكومة الإلكترونية")
  final String? doctorName; // اسم الدكتور (إذا كان متاحاً من API المقررات، أو يضاف لاحقاً)
  final String majorId; // ID التخصص المرتبط
  final String levelId; // ID المستوى المرتبط
  final String? subMajorId; // ID التخصص الفرعي المرتبط (اختياري)

  // أعداد العناصر لكل نوع من المواد (بيانات مشتقة أو تضاف لاحقاً من الـ API)
  final int examsCount;
  final int pdfsCount;
  final int booksCount;
  final int videosCount;

  CourseModel({
    required this.id,
    required this.title,
    this.doctorName,
    required this.majorId,
    required this.levelId,
    this.subMajorId,
    this.examsCount = 0,
    this.pdfsCount = 0,
    this.booksCount = 0,
    this.videosCount = 0,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    // بناءً على وثائق الـ API، نقطة نهاية Course ترجع 'title', 'levelId', 'majorId', 'subMajorId'
    // 'doctorName' و counts ليست موجودة مباشرة في API Course، لذا تُفترض قيم افتراضية أو تُربط لاحقاً
    return CourseModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? 'مادة غير معروفة'.tr,
      // 'doctorName' غير موجود في API Course، يمكن جلبه من LectureTime أو يُضاف في API
      doctorName: json['DoctorName'], // يمكن أن يكون null أو يعالج لاحقاً
      majorId: json['majorId']?.toString() ?? '',
      levelId: json['levelId']?.toString() ?? '',
      subMajorId: json['subMajorId']?.toString(),
      // هذه الأعداد غير موجودة في API Course، تُفترض 0 كقيم افتراضية
      examsCount: json['examsCount'] as int? ?? 0,
      pdfsCount: json['pdfsCount'] as int? ?? 0,
      booksCount: json['booksCount'] as int? ?? 0,
      videosCount: json['videosCount'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'DoctorName': doctorName, // لاحظ 'DoctorName' بحرف D كبير إذا كان مطابقاً للـ API
      'majorId': majorId,
      'levelId': levelId,
      'subMajorId': subMajorId,
      'examsCount': examsCount,
      'pdfsCount': pdfsCount,
      'booksCount': booksCount,
      'videosCount': videosCount,
    };
  }
}