// lib/data/models/teacher_model.dart
import 'package:get/get.dart'; // For .tr() method if used for translation

class TeacherModel {
  final String email;
  final String name;
  final String gender;
  // تم حذف collage و university لأنهما ليسا موجودين في استجابة user/admin/profile
  // final String? collage;
  // final String? university;
  final String teacherId; // سيمثل 'id' من استجابة الـ API

  TeacherModel({
    required this.email,
    required this.name,
    required this.gender,
    // تم حذف هذا من الـ constructor أيضاً
    // this.collage,
    // this.university,
    required this.teacherId,
  });

  factory TeacherModel.fromJson(Map<String, dynamic> json) {
    // تم تعديل المفتاح ليصبح 'userData' بناءً على الاستجابة الفعلية من user/admin/profile
    final adminData = json['userData'] as Map<String, dynamic>?;

    return TeacherModel(
      email: adminData?['email'] ?? 'default@teacher.com',
      name: adminData?['name'] ?? 'اسم مدرس غير معروف'.tr,
      gender: adminData?['gender'] ?? 'جنس غير معروف'.tr,
      // تم حذف collage و university من هنا
      // collage: adminData?['collage'],
      // university: adminData?['university'],
      teacherId: adminData?['id']?.toString() ?? '', // استخدام 'id' من الـ API
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'gender': gender,
      // تم حذف collage و university من هنا
      // 'collage': collage,
      // 'university': university,
      'id': teacherId, // إعادة تسميته ليتوافق مع الـ API إذا أردت إرساله
    };
  }
}