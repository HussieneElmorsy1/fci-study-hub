// lib/presentation/screens/courses_list_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fci_app_new/app_pages/app_routes.dart'; //
import 'package:fci_app_new/presentation/controllers/courses_list_controller.dart'; //
import 'package:fci_app_new/data/models/course_model.dart'; //
import 'package:fci_app_new/core/utils/app_theme.dart'; // For AppColors, AppTextStyles
import 'package:fci_app_new/styles/styles.dart'; //

class CoursesListScreen extends StatelessWidget {
  final CoursesListController controller = Get.put(CoursesListController(Get.find())); //
  final String majorName; // اسم التخصص لعرضه في الـ AppBar

  CoursesListScreen({super.key})
      : majorName = (Get.arguments is Map && Get.arguments.containsKey('majorName'))
            ? Get.arguments['majorName'] //
            : 'المقررات';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(majorName.tr), // عرض اسم التخصص
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // منطق البحث عن المواد
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('حدث خطأ: ${controller.errorMessage.value}'.tr),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => controller.fetchCourses(controller.majorId.value),
                  child: Text('إعادة المحاولة'.tr),
                ),
              ],
            ),
          );
        } else if (controller.courses.isEmpty) {
          return Center(child: Text('لا توجد مقررات لعرضها في هذا التخصص'.tr));
        } else {
          return RefreshIndicator(
            onRefresh: () => controller.fetchCourses(controller.majorId.value),
            child: GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, //
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.65, //
              ),
              itemCount: controller.courses.length,
              itemBuilder: (context, index) {
                final course = controller.courses[index];
                return CourseCard(course: course); //
              },
            ),
          );
        }
      }),
    );
  }
}

// Widget مخصص لبطاقة المقرر الدراسي (Course Card)
class CourseCard extends StatelessWidget {
  final CourseModel course; //

  const CourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // عنوان المقرر
            Text(
              course.title, //
              style: AppTextStyles.headline3, //
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 5),
            // اسم الدكتور
            Row(
              children: [
                Icon(Icons.person, size: 18, color: AppColors.secondary), //
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    'د. ${course.doctorName ?? 'غير متاح'.tr}', //
                    style: AppTextStyles.bodyTextSmall
                        .copyWith(color: Colors.grey[600]), //
                    maxLines: 1, //
                    overflow: TextOverflow.ellipsis, //
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // الأيقونات والمربعات الفرعية (Exams, PDFs, Books, Videos)
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, //
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 4.0, //
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildMaterialTypeItem(context, 'Exams', Icons.assignment,
                      course.examsCount, 'exams', course.id, course.title, course.doctorName),
                  _buildMaterialTypeItem(context, 'PDFs', Icons.picture_as_pdf,
                      course.pdfsCount, 'pdfs', course.id, course.title, course.doctorName),
                  _buildMaterialTypeItem(context, 'Books', Icons.book,
                      course.booksCount, 'books', course.id, course.title, course.doctorName),
                  _buildMaterialTypeItem(
                      context,
                      'Videos',
                      Icons.play_circle_fill,
                      course.videosCount,
                      'videos',
                      course.id,
                      course.title,
                      course.doctorName),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget مساعد لإنشاء عنصر نوع المادة (Exam, PDF, Book, Video)
  Widget _buildMaterialTypeItem(
    BuildContext context,
    String title,
    IconData icon,
    int count,
    String materialType, // نوع المادة لتمريره للصفحة التالية (مثال: 'pdfs')
    String courseId, // ID المقرر لتمريره للصفحة التالية
    String courseTitle, // عنوان المقرر
    String? doctorName, // اسم الدكتور (اختياري)
  ) {
    return GestureDetector(
      onTap: () {
        // عند الضغط على نوع المادة، انتقل إلى شاشة عرض المحتوى الجديدة
        Get.toNamed(AppRoutes.MATERIAL_VIEWER, arguments: { // <--- تم التعديل هنا: التوجيه إلى MATERIAL_VIEWER
          'courseId': courseId,
          'materialType': materialType,
          'courseTitle': courseTitle,
          'doctorName': doctorName,
        });
      },
      child: Card(
        color: AppColors.secondary.withOpacity(0.1), //
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0), //
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min, //
            children: [
              Flexible( //
                child: Icon(icon, size: 24, color: AppColors.secondary), //
              ),
              Flexible( //
                child: Text(
                  title,
                  style: AppTextStyles.bodyTextSmall.copyWith(fontSize: 11), //
                  maxLines: 1, //
                  overflow: TextOverflow.ellipsis, //
                  textAlign: TextAlign.center, //
                ),
              ),
              Flexible( //
                child: Text(
                  '${count} items'.tr, //
                  style: AppTextStyles.bodyTextSmall
                      .copyWith(color: Colors.grey[600], fontSize: 9), //
                  maxLines: 1, //
                  overflow: TextOverflow.ellipsis, //
                  textAlign: TextAlign.center, //
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}