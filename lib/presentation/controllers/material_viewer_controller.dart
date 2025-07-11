// lib/presentation/controllers/material_viewer_controller.dart
import 'dart:developer';
import 'package:get/get.dart';
import 'package:fci_app_new/data/models/material_item_model.dart'; //
import 'package:fci_app_new/domain/usecases/get_materials_by_course_and_type_use_case.dart'; //
import 'package:fci_app_new/domain/repository/auth_repository.dart'; // // لجلب دور المستخدم
import 'package:dio/dio.dart'; //

class MaterialViewerController extends GetxController {
  final GetMaterialsByCourseAndTypeUseCase _getMaterialsUseCase; //
  final AuthRepository _authRepository; //

  final RxList<MaterialItemModel> currentMaterials = <MaterialItemModel>[].obs; //
  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;
  final RxString currentCourseId = ''.obs;
  final RxString currentMaterialType = ''.obs; // لتتبع التبويب النشط
  final RxBool isTeacher = false.obs; // لتحديد صلاحيات العرض (للمدرسين)

  MaterialViewerController(this._getMaterialsUseCase, this._authRepository); //

  @override
  void onInit() {
    super.onInit();
    _checkUserRole();
    // الحصول على courseId والنوع الأولي من الـ arguments
    if (Get.arguments is Map) {
      currentCourseId.value = Get.arguments['courseId'] as String? ?? '';
      currentMaterialType.value = Get.arguments['materialType'] as String? ?? 'pdfs'; // افتراضياً pdfs
    } else {
      errorMessage('Course ID or material type not provided.');
      isLoading(false);
    }
  }

  // التحقق من دور المستخدم (طالب/مدرس)
  Future<void> _checkUserRole() async {
    final role = await _authRepository.getUserRole(); //
    isTeacher.value = (role == 'admin'); // إذا كان الدور 'admin' فهو مدرس
    log('MaterialViewerController: User role is ${role}, isTeacher: ${isTeacher.value}');
  }

  // جلب المواد بناءً على نوع المادة (pdf, video, etc.)
  Future<void> fetchMaterials(String materialType) async {
    // تحديث التبويب النشط فقط إذا كان هناك تغيير
    if (currentMaterialType.value != materialType || currentMaterials.isEmpty) {
      currentMaterialType.value = materialType;
      isLoading(true);
      errorMessage('');
      currentMaterials.clear(); // مسح القائمة الحالية قبل جلب الجديد

      try {
        final fetchedMaterials = await _getMaterialsUseCase.call(currentCourseId.value, materialType); //
        currentMaterials.assignAll(fetchedMaterials);
        log('MaterialViewerController: Fetched ${fetchedMaterials.length} ${materialType} items.');
      } on DioException catch (e) { //
        errorMessage('خطأ في الشبكة/الـ API: ${e.message}'.tr);
        log('DioException in MaterialViewerController.fetchMaterials: $e');
      } catch (e) {
        errorMessage('حدث خطأ غير متوقع: ${e.toString()}'.tr);
        log('Unhandled error in MaterialViewerController.fetchMaterials: $e');
      } finally {
        isLoading(false);
      }
    }
  }

  // دالة مساعدة لتصفية المواد المعروضة حالياً
  List<MaterialItemModel> getMaterialsForType(String type) {
    return currentMaterials.where((material) => material.type == type).toList(); //
  }

  // دوال الإدارة (للمدرسين فقط)
  Future<void> addMaterial() async {
    // منطق إضافة مادة جديدة
    Get.snackbar('إضافة مادة', 'سيتم فتح شاشة إضافة مادة جديدة');
    // هنا يمكن توجيه لشاشة إضافة مادة أو فتح ديالوج
  }

  Future<void> editMaterial(MaterialItemModel material) async {
    // منطق تعديل مادة موجودة
    Get.snackbar('تعديل مادة', 'تعديل: ${material.title}'); //
    // هنا يمكن توجيه لشاشة تعديل مادة أو فتح ديالوج
  }

  Future<void> deleteMaterial(String materialId) async {
    // منطق حذف مادة
    Get.snackbar('حذف مادة', 'حذف المادة ID: $materialId');
    // هنا يمكن عرض ديالوج تأكيد ثم استدعاء الـ repository لحذف المادة
  }
}