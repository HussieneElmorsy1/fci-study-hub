// lib/presentation/screens/lecture_schedule_screen.dart
import 'package:fci_app_new/app_pages/app_routes.dart';
import 'package:fci_app_new/data/models/lecture_time_model.dart';
import 'package:fci_app_new/presentation/controllers/lecture_schedule_controller.dart';
import 'package:fci_app_new/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fci_app_new/app_pages/app_routes.dart';
import 'package:fci_app_new/presentation/controllers/lecture_schedule_controller.dart';
import 'package:fci_app_new/data/models/lecture_time_model.dart';

class LectureScheduleScreen extends StatelessWidget {
  final LectureScheduleController controller =
      Get.find<LectureScheduleController>();

  LectureScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('جدول المحاضرات'.tr),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // منطق البحث
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
                  onPressed: controller.fetchLectureTimes,
                  child: Text('إعادة المحاولة'.tr),
                ),
              ],
            ),
          );
        } else if (controller.lectureTimes.isEmpty) {
          return Center(child: Text('لا توجد مواعيد محاضرات لعرضها'.tr));
        } else {
          return RefreshIndicator(
            onRefresh: controller.fetchLectureTimes,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // بطاقات "محاضرات", "قادم", "سكاشن" (بيانات وهمية حالياً)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // تم تحديث استدعاء _buildTopCard هنا
                      _buildTopCard(context, 'محاضرات'.tr,
                          'assets/images/lecture_schedule_screen/book_icon.png'),
                      _buildTopCard(context, 'قادم'.tr,
                          'assets/images/lecture_schedule_screen/clock_icon.png'),
                      _buildTopCard(context, 'سكاشن'.tr,
                          'assets/images/lecture_schedule_screen/la_chalkboard-teacher.png'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text('المواعيد'.tr, style: AppTextStyles.headline3),
                  const SizedBox(height: 10),
                  // قائمة مواعيد المحاضرات
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.lectureTimes.length,
                    itemBuilder: (context, index) {
                      final lecture = controller.lectureTimes[index];
                      return LectureTimeItem(lecture: lecture);
                    },
                  ),
                  const SizedBox(height: 30),
                  Text('إحصائيات التفاعل'.tr, style: AppTextStyles.headline3),
                  const SizedBox(height: 10),
                  // قسم إحصائيات التفاعل (بيانات وهمية/غير مدعومة حالياً)
                  _buildInteractionStats(),
                  const SizedBox(height: 30),
                  Text('نظرة عامة على الحضور'.tr,
                      style: AppTextStyles.headline3),
                  const SizedBox(height: 10),
                  // قسم نظرة عامة على الحضور (بيانات وهمية/غير مدعومة حالياً)
                  _buildAttendanceOverview(),
                ],
              ),
            ),
          );
        }
      }),
      // يمكنك إضافة BottomNavigationBar هنا إذا كانت الشاشة جزءاً من هيكل شامل
    );
  }

  // Widget مساعد لإنشاء بطاقات الجزء العلوي
  // تم تعديل هذا الـ Widget لاستقبال مسار الصورة بدلاً من IconData
  Widget _buildTopCard(BuildContext context, String title, String imagePath) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        width: Get.width * 0.25,
        height: 90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0), // مسافة داخل الدائرة
              decoration: BoxDecoration(
                color: AppColors.primary
                    .withValues(alpha: 0.1), // لون أغمق قليلاً كظل/دائرة
                shape: BoxShape.circle, // جعل الشكل دائري
              ),
              child: Image.asset(
                imagePath, // استخدام الصورة من الـ assets
                width: 30, // حجم الصورة داخل الدائرة
                height: 30,
                // color: AppColors.kPrimaryColor, // يمكن تطبيق لون على الصورة إذا كانت أحادية اللون
              ),
            ),
            const SizedBox(height: 5),
            Text(title, style: AppTextStyles.bodyTextSmall),
          ],
        ),
      ),
    );
  }

  // Widget مساعد لقسم إحصائيات التفاعل (بيانات وهمية)
  Widget _buildInteractionStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildStatItem('عدد الطلاب'.tr, '150'),
        _buildStatItem('محاضرات مكتملة'.tr, '30'),
        _buildStatItem('معدل إيجابية'.tr, '85%'),
      ],
    );
  }

  // Widget مساعد لقسم نظرة عامة على الحضور (بيانات وهمية)
  Widget _buildAttendanceOverview() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildStatItem('إجمالي المحاضرات'.tr, '5'),
        _buildStatItem('حضر'.tr, '3\n+1', isAttendance: true),
        _buildStatItem('متغيب'.tr, '2\n-1', isAttendance: true),
      ],
    );
  }

  // Widget مساعد لعرض عنصر إحصائي
  Widget _buildStatItem(String title, String value,
      {bool isAttendance = false}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        width: Get.width * 0.28,
        height: isAttendance ? 120 : 90,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title,
                  style: AppTextStyles.bodyTextSmall,
                  textAlign: TextAlign.center),
              const SizedBox(height: 5),
              Text(value,
                  style: AppTextStyles.headline3
                      .copyWith(color: AppColors.primary),
                  textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget مخصص لعرض عنصر موعد المحاضرة (مماثل لـ ProfileItem ولكن لبيانات المحاضرة)
class LectureTimeItem extends StatelessWidget {
  final LectureTimeModel lecture;

  const LectureTimeItem({super.key, required this.lecture});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Icon(Icons.schedule, color: AppColors.secondary),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lecture.courseName,
                    style: AppTextStyles.bodyTextBold,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'د/ ${lecture.doctorName}',
                    style: AppTextStyles.bodyTextSmall
                        .copyWith(color: Colors.grey[600]),
                  ),
                  Text(
                    lecture.rangeTime,
                    style: AppTextStyles.bodyTextSmall
                        .copyWith(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
