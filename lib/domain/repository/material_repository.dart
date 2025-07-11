// lib/domain/repository/material_repository.dart
import 'package:fci_app_new/data/models/material_item_model.dart'; //

abstract class MaterialRepository {
  Future<List<MaterialItemModel>> getMaterialsByCourseAndType(String courseId, String materialType);
  // يمكنك إضافة دوال مجردة أخرى هنا لعمليات إدارة المواد (إضافة، تعديل، حذف)
  // Future<MaterialItemModel> addMaterial(MaterialItemModel material);
  // Future<void> updateMaterial(MaterialItemModel material);
  // Future<void> deleteMaterial(String materialId);
}