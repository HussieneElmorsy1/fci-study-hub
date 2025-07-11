// lib/domain/repository/major_repository.dart
import 'package:fci_app_new/data/models/major_model.dart'; //

abstract class MajorRepository {
  Future<List<MajorModel>> getAllMajors();
  Future<MajorModel> getMajorById(String id); // دالة جديدة لجلب تخصص بالـ ID
  Future<MajorModel> createMajor(String title); // دالة جديدة لإنشاء تخصص
}