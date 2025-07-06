// lib/domain/repository/profile_repository.dart
import 'package:fci_app_new/data/models/profile_model.dart'; //
import 'package:fci_app_new/data/models/teacher_model.dart'; // استيراد TeacherModel الجديد

abstract class ProfileRepository {
  Future<ProfileModel> getStudentProfile();
  Future<TeacherModel> getTeacherProfile(); // دالة مجردة جديدة لجلب ملف تعريف المدرس
}