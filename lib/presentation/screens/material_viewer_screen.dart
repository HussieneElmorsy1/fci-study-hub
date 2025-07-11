// lib/presentation/screens/material_viewer_screen.dart
import 'package:fci_app_new/presentation/screens/pdf_viewer_screen.dart';
import 'package:fci_app_new/presentation/widgets/video_player_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fci_app_new/app_pages/app_routes.dart'; //
import 'package:fci_app_new/presentation/controllers/material_viewer_controller.dart'; //
import 'package:fci_app_new/data/models/material_item_model.dart'; //
import 'package:fci_app_new/core/utils/app_theme.dart'; // // For AppColors, AppTextStyles
import 'package:fci_app_new/styles/styles.dart'; //

class MaterialViewerScreen extends StatefulWidget {
  // **التعديل الحاسم هنا:** قم بإزالة كلمة 'required' من المعاملات
  final String? courseId;
  final String? courseTitle;
  final String? initialMaterialType; // 'pdfs', 'videos', 'books', 'exams'

  const MaterialViewerScreen({
    Key? key,
    this.courseId, // <--- تم إزالة 'required'
    this.courseTitle, // <--- تم إزالة 'required'
    this.initialMaterialType, // <--- تم إزالة 'required'
  }) : super(key: key);

  @override
  State<MaterialViewerScreen> createState() => _MaterialViewerScreenState();
}

class _MaterialViewerScreenState extends State<MaterialViewerScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late MaterialViewerController controller;

  // عناوين التبويبات التي ستظهر للمستخدم
  final List<String> _tabTitles = ['الكتب'.tr, 'الفيديوهات'.tr, 'ملفات PDF'.tr, 'الاختبارات'.tr];
  // أنواع المواد المقابلة لنقاط النهاية أو المنطق (يجب أن تتطابق مع 'type' في MaterialItemModel)
  final List<String> _materialTypes = ['books', 'videos', 'pdfs', 'exams'];

  // متغير لتخزين عنوان المقرر الذي سيتم عرضه في الـ AppBar
  String _courseTitle = 'المواد'; // قيمة افتراضية

  @override
  void initState() {
    super.initState();
    // الحصول على المتحكم
    controller = Get.put(MaterialViewerController(Get.find(), Get.find())); //
    
    // الحصول على الـ arguments هنا في initState
    final arguments = Get.arguments as Map<String, dynamic>?;
    final String courseId = arguments?['courseId'] as String? ?? '';
    final String initialMaterialType = arguments?['materialType'] as String? ?? 'pdfs';
    _courseTitle = arguments?['courseTitle'] as String? ?? 'المواد';

    // تهيئة المتحكم بالـ courseId و initialMaterialType
    controller.currentCourseId.value = courseId;
    controller.currentMaterialType.value = initialMaterialType; // تحديد التبويب الأولي في المتحكم

    // تحديد التبويب الأولي لـ TabController بناءً على الـ arguments
    final initialIndex = _materialTypes.indexOf(initialMaterialType);
    _tabController = TabController(
      length: _tabTitles.length,
      vsync: this,
      initialIndex: initialIndex != -1 ? initialIndex : 0,
    );

    // جلب البيانات للتبويب الأولي
    controller.fetchMaterials(_materialTypes[_tabController.index]);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging && _tabController.animation!.isCompleted) {
        controller.fetchMaterials(_materialTypes[_tabController.index]);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_courseTitle), // استخدام عنوان المقرر المخزن في _courseTitle
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // منطق البحث عن المواد داخل هذه الصفحة
            },
          ),
          // زر "إضافة" للمدرسين فقط
          Obx(() {
            if (controller.isTeacher.value) { //
              return IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  // منطق إضافة مادة جديدة (سيكون خاصاً بالمدرسين)
                  Get.snackbar('إضافة', 'وظيفة الإضافة هنا');
                },
              );
            }
            return const SizedBox.shrink();
          }),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: _tabTitles.map((title) => Tab(text: title)).toList(),
          isScrollable: true, //
          labelStyle: AppTextStyles.bodyTextBold, //
          unselectedLabelStyle: AppTextStyles.bodyTextSmall, //
          indicatorColor: AppColors.primary, //
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _materialTypes.map((type) {
          return _buildMaterialGrid(type); // دالة مساعدة لعرض الشبكة لكل تبويب
        }).toList(),
      ),
    );
  }

  // دالة مساعدة لبناء شبكة المواد لكل تبويب
  Widget _buildMaterialGrid(String materialType) {
    return Obx(() {
      // عرض مؤشر التحميل فقط للتبويب النشط
      if (controller.isLoading.value && controller.currentMaterialType.value == materialType) {
        return const Center(child: CircularProgressIndicator());
      } else if (controller.errorMessage.isNotEmpty && controller.currentMaterialType.value == materialType) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('حدث خطأ: ${controller.errorMessage.value}'.tr), //
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => controller.fetchMaterials(materialType), //
                child: Text('إعادة المحاولة'.tr),
              ),
            ],
          ),
        );
      } else {
        final List<MaterialItemModel> materials = controller.getMaterialsForType(materialType); //
        if (materials.isEmpty) {
          return Center(child: Text('لا توجد عناصر لعرضها في هذا القسم'.tr));
        }
        return GridView.builder(
          padding: const EdgeInsets.all(16.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, //
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 0.7, //
          ),
          itemCount: materials.length,
          itemBuilder: (context, index) {
            final material = materials[index];
            return MaterialItemCard(material: material, controller: controller); //
          },
        );
      }
    });
  }
}

// Widget مخصص لبطاقة عنصر المادة (PDF, Video, Exam, Book)
class MaterialItemCard extends StatelessWidget {
  final MaterialItemModel material; //
  final MaterialViewerController controller; //

  const MaterialItemCard({super.key, required this.material, required this.controller});

  @override
  Widget build(BuildContext context) {
    IconData itemIcon;
    switch (material.type) {
      case 'pdfs':
      case 'books': // الكتب أيضاً تظهر كـ PDF
      case 'exams': // الاختبارات أيضاً تظهر كـ PDF
        itemIcon = Icons.picture_as_pdf;
        break;
      case 'videos':
        itemIcon = Icons.play_circle_fill;
        break;
      default:
        itemIcon = Icons.folder;
    }

    return GestureDetector(
      onTap: () {
        // منطق فتح الملف/الفيديو/الاختبار
        if (material.url.isNotEmpty) {
          // ** هنا يتم تعديل منطق الفتح لتوجه إلى الشاشة الصحيحة **
          if (material.type == 'pdfs' || material.type == 'books' || material.type == 'exams') {
            // توجيه إلى PdfViewerScreen لملفات PDF والكتب والاختبارات
            Get.to(() => PdfViewerScreen(material: material)); //
          } else if (material.type == 'videos') {
            // توجيه إلى VideoPlayerScreen للفيديوهات
            Get.to(() => VideoPlayerScreen(videoUrl: material.url)); //
          } else {
            // لغة احتياطية لأنواع المواد غير المعروفة
            Get.snackbar('غير مدعوم', 'نوع المادة غير مدعوم حالياً للعرض.');
          }
        } else {
          Get.snackbar('خطأ', 'لا يوجد رابط للمادة');
        }
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(itemIcon, size: 50, color: AppColors.primary),
            const SizedBox(height: 10),
            Text(
              material.title,
              style: AppTextStyles.bodyTextBold,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 5),
            // أزرار الإدارة (للمدرسين فقط)
            Obx(() {
              if (controller.isTeacher.value) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    if (material.canEdit)
                      IconButton(
                        icon: const Icon(Icons.edit, size: 20, color: Colors.blue),
                        onPressed: () {
                          Get.snackbar('تعديل', 'تعديل: ${material.title}');
                        },
                      ),
                    if (material.canDelete)
                      IconButton(
                        icon: const Icon(Icons.delete, size: 20, color: Colors.red),
                        onPressed: () {
                          Get.snackbar('حذف', 'حذف: ${material.title}');
                        },
                      ),
                  ],
                );
              }
              return const SizedBox.shrink();
            }),
          ],
        ),
      ),
    );
  }
}