// lib/presentation/screens/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fci_app_new/app_pages/app_routes.dart'; //
import 'package:fci_app_new/presentation/widgets/horizontal_line.dart'; //
import 'package:fci_app_new/presentation/widgets/profile_item.dart'; //
import 'package:fci_app_new/presentation/controllers/profile_controller.dart'; //
import 'package:fci_app_new/data/models/profile_model.dart'; //
import 'package:fci_app_new/data/models/teacher_model.dart'; //

class ProfileScreen extends StatelessWidget {
  final ProfileController controller = Get.find<ProfileController>(); //

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('4.1'.tr),
        centerTitle: true,
        actions: [
          Obx(
            () => IconButton(
              icon: Icon(Icons.refresh, color: controller.isLoading.value ? Colors.grey : null),
              onPressed: controller.isLoading.value ? null : controller.fetchProfile,
              tooltip: '4.2'.tr,
            ),
          ),
        ],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('4.3'.tr + '\n${controller.errorMessage.value}', textAlign: TextAlign.center,),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: controller.fetchProfile,
                  child: Text('4.4'.tr),
                ),
              ],
            ),
          );
        } else if (controller.userProfile.value == null) {
          return Center(child: Text('4.5'.tr)); // بيانات الملف الشخصي غير متوفرة
        } else {
          // عرض البيانات بناءً على نوع النموذج (طالب أو مدرس)
          return buildProfileView(context, controller.userProfile.value);
        }
      }),
      extendBody: true,
    );
  }

  Widget buildProfileView(BuildContext context, dynamic profile) {
    return RefreshIndicator(
      onRefresh: () async {
        await controller.fetchProfile();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.blue,
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // عرض البريد الإلكتروني (موجود في كلا النموذجين)
                    Text(
                      profile.email,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              HorizontalLine(color: Theme.of(context).dividerColor),
              // عرض الحقول المشتركة
              ProfileItem(title: 'الاسم'.tr, value: profile.name),
              ProfileItem(title: 'النوع'.tr, value: profile.gender),

              // عرض الحقول الخاصة بالدور (طالب أو مدرس)
              if (profile is ProfileModel) // إذا كان النموذج هو ProfileModel (طالب)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileItem(title: 'الكلية'.tr, value: profile.collage ?? 'غير متاح'.tr),
                    ProfileItem(title: 'الجامعة'.tr, value: profile.university ?? 'غير متاح'.tr),
                    ProfileItem(title: 'المستوى'.tr, value: profile.level),
                    ProfileItem(title: 'التخصص'.tr, value: profile.major),
                    ProfileItem(title: 'الرقم الجامعي'.tr, value: profile.universityId),
                    ProfileItem(title: 'المعدل التراكمي'.tr, value: profile.gpa.toStringAsFixed(1)),
                  ],
                )
              else if (profile is TeacherModel) // إذا كان النموذج هو TeacherModel (مدرس)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // عرض الحقول المتاحة فقط في استجابة user/admin/profile
                    ProfileItem(title: 'رقم المدرس'.tr, value: profile.teacherId),
                    // حقول أخرى (القسم، الرتبة، المكتب) غير متوفرة في استجابة API الحالية
                    ProfileItem(title: 'الكلية'.tr, value: 'غير متاح'.tr), // لا توجد كلية صراحة للمدرس في API
                    ProfileItem(title: 'الجامعة'.tr, value: 'غير متاح'.tr), // لا توجد جامعة صراحة للمدرس في API
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}