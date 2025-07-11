// lib/app_pages/app_pages.dart
import 'dart:developer'; //

import 'package:fci_app_new/app_pages/app_routes.dart'; //
import 'package:fci_app_new/data/models/material_item_model.dart';
import 'package:fci_app_new/presentation/controllers/login_controller.dart'; //
import 'package:fci_app_new/data/providers/document_provider.dart'; //
import 'package:fci_app_new/data/services/onboarding_service.dart'; //
import 'package:fci_app_new/presentation/screens/chat_screen.dart'; //
import 'package:fci_app_new/presentation/screens/chats_screen.dart'; //
import 'package:fci_app_new/presentation/screens/draft_file.dart'; //
import 'package:fci_app_new/presentation/screens/forgot_password_screen.dart'; //
import 'package:fci_app_new/presentation/screens/home_screen.dart'; //
import 'package:fci_app_new/presentation/screens/login_screen.dart'; //
import 'package:fci_app_new/presentation/screens/main_home_screen.dart'; //
import 'package:fci_app_new/presentation/screens/material_viewer_screen.dart'; //
import 'package:fci_app_new/presentation/screens/more_screen.dart'; //
import 'package:fci_app_new/presentation/screens/onboarding_screen.dart'; //
// تم إزالة: import 'package:fci_app_new/presentation/screens/pdf_screen.dart'; // سيزال هذا
import 'package:fci_app_new/presentation/screens/pdf_viewer_screen.dart'; //
import 'package:fci_app_new/presentation/screens/profile_screen.dart'; //
import 'package:fci_app_new/presentation/screens/role_selection_screen.dart'; //
import 'package:fci_app_new/presentation/screens/schedule_screen.dart'; //
import 'package:fci_app_new/presentation/screens/splash_screen.dart'; //
// تم إزالة: import 'package:fci_app_new/presentation/screens/video_screen.dart'; // سيزال هذا
import 'package:fci_app_new/presentation/screens/lecture_schedule_screen.dart'; //
import 'package:fci_app_new/presentation/screens/courses_list_screen.dart'; //

import 'package:flutter/material.dart'; //
import 'package:get/get.dart'; //
import 'package:shared_preferences/shared_preferences.dart'; //

// استيراد الـ Bindings
import 'package:fci_app_new/app_pages/bindings/auth_binding.dart'; //
import 'package:fci_app_new/app_pages/bindings/profile_binding.dart'; //
import 'package:fci_app_new/app_pages/bindings/lecture_schedule_binding.dart'; //
import 'package:fci_app_new/app_pages/bindings/majors_binding.dart'; //
import 'package:fci_app_new/app_pages/bindings/courses_list_binding.dart'; //
import 'package:fci_app_new/app_pages/bindings/material_viewer_binding.dart'; //
import 'package:fci_app_new/presentation/controllers/add_event_controller.dart'; //


class AppPages {
  static final routes = [
    _splashRoute(),
    _onboardingRoute(),
    _onboardingOrHomeRoute(),
    _mainHomeRoute(),
    _homeRoute(),
    _forgotPasswordRoute(),
    _loginRoute(),
    _scheduleRoute(),
    _profileRoute(),
    _moreRoute(),
    // تم حذف: _pdfScreenRoute(), // تم حذف هذا المسار
    // _pdfViewerRoute(), // هذا المسار لفتح الـ PDF Viewer (مختلف عن شاشة عرض المواد)
    // تم حذف: _videoScreen(), // تم حذف هذا المسار
    _chatsRoute(),
    _chatRoute(),
    _roleSelectionRoute(),
    _coursesListRoute(),
    _materialViewerRoute(),
  ];

  static GetPage _splashRoute() {
    return GetPage(
      name: AppRoutes.SPLASH, //
      page: () => const SplashScreen(), //
      transition: Transition.fade, //
    );
  }

  static GetPage _onboardingRoute() {
    return GetPage(
      name: AppRoutes.ONBOARDING, //
      page: () => const OnboardingScreen(), //
      transition: Transition.rightToLeft, //
    );
  }

  static GetPage _onboardingOrHomeRoute() {
    return GetPage(
      name: AppRoutes.ONBOARDING_OR_HOME, //
      page: () => FutureBuilder<bool>(
        future: OnboardingService.isOnboardingCompleted(), //
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) { //
            return const Center(child: CircularProgressIndicator()); //
          }

          if (snapshot.hasData) { //
            final onboardingCompleted = snapshot.data!; //
            if (!onboardingCompleted) { //
              return const OnboardingScreen(); //
            } else {
              return FutureBuilder<bool>(
                future: _checkLocalLoginStatus(), //
                builder: (context, loginSnapshot) {
                  if (loginSnapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final isLoggedIn = loginSnapshot.data ?? false;
                  if (isLoggedIn) {
                    log('User is logged in (local token), navigating to MainHomeScreen');
                    return const MainHomeScreen(); //
                  }
                  log('User is not logged in (no local token), navigating to RoleSelectionScreen');
                  return const RoleSelectionScreen(); //
                },
              );
            }
          }
          return const Center(child: CircularProgressIndicator()); //
        },
      ),
    );
  }

  // دالة مساعدة جديدة للتحقق من حالة تسجيل الدخول محلياً
  static Future<bool> _checkLocalLoginStatus() async {
    final prefs = await SharedPreferences.getInstance(); //
    final token = prefs.getString('token');
    return token != null && token.isNotEmpty;
  }

  static GetPage _mainHomeRoute() {
    return GetPage(
      name: AppRoutes.MAIN_HOME_SCREEN, //
      page: () => const MainHomeScreen(), //
      transition: Transition.zoom, //
    );
  }

  static GetPage _homeRoute() {
    return GetPage(
      name: AppRoutes.HOME_SCREEN, //
      page: () => HomeScreen(), //
      binding: MajorsBinding(), //
      transition: Transition.zoom, //
    );
  }

  static GetPage _forgotPasswordRoute() {
    return GetPage(
      name: AppRoutes.FORGOT_PASSWORD, //
      page: () => ForgotPasswordScreen(), //
      transition: Transition.rightToLeft, //
    );
  }

  static GetPage _loginRoute() {
    return GetPage(
      name: AppRoutes.LOGIN, //
      page: () => LoginScreen(), //
      binding: AuthBinding(), //
    );
  }

  // تم تعديل هذا المسار ليربط بشاشة جدول المحاضرات الجديدة
  static GetPage _scheduleRoute() {
    return GetPage(
      name: AppRoutes.SCHEDULE, //
      page: () => LectureScheduleScreen(), //
      binding: LectureScheduleBinding(), //
      transition: Transition.zoom, //
    );
  }

  static GetPage _profileRoute() {
    return GetPage(
      name: AppRoutes.PROFILE, //
      page: () => ProfileScreen(), //
      binding: ProfileBinding(), //
      transition: Transition.zoom, //
    );
  }

  static GetPage _moreRoute() {
    return GetPage(
      name: AppRoutes.MORE, //
      page: () => const MoreScreen(), //
      transition: Transition.zoom, //
    );
  }

  // تم إزالة مسار _pdfScreenRoute() القديم واستبداله بـ MaterialViewerRoute
  // static GetPage _pdfScreenRoute() {
  //   return GetPage(
  //     name: AppRoutes.PDF_SCREEN, //
  //     page: () { //
  //       final title = Get.arguments as String; //
  //       return PdfScreen(title: title); //
  //     },
  //     binding: BindingsBuilder(() { //
  //       Get.lazyPut(() => DocumentProvider()); //
  //     }),
  //     transition: Transition.zoom, //
  //   );
  // }

  // static GetPage _pdfViewerRoute() {
  //   return GetPage(
  //     name: AppRoutes.PDF_VIEWER, // [cite: uploaded:lib/app_pages/app_routes.dart]
  //     page: () {
  //       // يجب أن يتم تمرير MaterialItemModel كـ argument
  //       final material = Get.arguments as MaterialItemModel; // <--- تم التعديل هنا
  //       // collectionId لم يعد مطلوباً هنا
  //       // final collectionId = arguments['collectionId'];
  //       return PdfViewerScreen(
  //         material: material, // <--- تم التعديل هنا
  //         // collectionId: collectionId, // تم حذفه
  //       );
  //     },
  //   );
  // }
  
  // تم إزالة مسار _videoScreen() القديم واستبداله بـ MaterialViewerRoute
  // static GetPage _videoScreen() {
  //   return GetPage(
  //     name: AppRoutes.VIDEO_SCREEN, //
  //     page: () => const VideoScreen(), //
  //   );
  // }

  static GetPage _chatsRoute() {
    return GetPage(
      name: AppRoutes.CHATS, //
      page: () => const ChatsScreen(), //
      transition: Transition.zoom, //
    );
  }

  static GetPage _chatRoute() {
    return GetPage(
      name: AppRoutes.CHAT, //
      page: () => const ChatScreen(), //
      transition: Transition.rightToLeft, //
    );
  }

  static GetPage _roleSelectionRoute() {
    return GetPage(
      name: AppRoutes.ROLE_SELECTION, //
      page: () => const RoleSelectionScreen(), //
      transition: Transition.rightToLeft, //
    );
  }

  static GetPage _coursesListRoute() {
    return GetPage(
      name: AppRoutes.COURSES_LIST, //
      page: () => CoursesListScreen(), //
      binding: CoursesListBinding(), //
      transition: Transition.zoom, //
    );
  }

  static GetPage _materialViewerRoute() {
    // return GetPage(
    //   name: AppRoutes.MATERIAL_VIEWER, //
    //   page: () => MaterialViewerScreen(
    //     courseId: Get.arguments['courseId'], //
    //     courseTitle: Get.arguments['courseTitle'], //
    //     initialMaterialType: Get.arguments['materialType'], //
    //   ),
    //   binding: MaterialViewerBinding(), //
    //   transition: Transition.zoom, //
    // );
    return GetPage(
      name: AppRoutes.MATERIAL_VIEWER, //
      page: () => const MaterialViewerScreen(), //
      binding: MaterialViewerBinding(), //
      transition: Transition.rightToLeft, //
    );
  }
}