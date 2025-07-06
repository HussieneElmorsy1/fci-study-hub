// app_pages.dart
import 'dart:developer'; //

import 'package:fci_app_new/app_pages/app_routes.dart'; //
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
import 'package:fci_app_new/presentation/screens/more_screen.dart'; //
import 'package:fci_app_new/presentation/screens/onboarding_screen.dart'; //
import 'package:fci_app_new/presentation/screens/pdf_screen.dart'; //
import 'package:fci_app_new/presentation/screens/pdf_viewer_screen.dart'; //
import 'package:fci_app_new/presentation/screens/profile_screen.dart'; //
import 'package:fci_app_new/presentation/screens/role_selection_screen.dart'; //
import 'package:fci_app_new/presentation/screens/schedule_screen.dart'; //
import 'package:fci_app_new/presentation/screens/splash_screen.dart'; //
import 'package:fci_app_new/presentation/screens/video_screen.dart'; //
import 'package:flutter/material.dart'; //
import 'package:get/get.dart'; //
import 'package:shared_preferences/shared_preferences.dart'; // لإزالة Firebase auth state

// استيراد الـ Bindings
import 'package:fci_app_new/app_pages/bindings/auth_binding.dart'; //
import 'package:fci_app_new/app_pages/bindings/profile_binding.dart'; // استيراد ProfileBinding الجديد
import 'package:fci_app_new/presentation/controllers/add_event_controller.dart'; //


class AppPages {
  static final routes = [
    _splashRoute(), //
    _onboardingRoute(), //
    _onboardingOrHomeRoute(), //
    _mainHomeRoute(), //
    _homeRoute(), //
    _forgotPasswordRoute(), //
    _loginRoute(), //
    _scheduleRoute(), //
    _profileRoute(), //
    _moreRoute(), //
    _pdfScreenRoute(), //
    _pdfViewerRoute(), //
    _videoScreen(), //
    _chatsRoute(), //
    _chatRoute(), //
    _roleSelectionRoute(), //
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
              // هذا هو الجزء الذي تم تعديله لإزالة اعتمادية Firebase Auth
              return FutureBuilder<bool>(
                future: _checkLocalLoginStatus(), // دالة جديدة للتحقق من التوكن محلياً
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
                  return const RoleSelectionScreen(); // <--- تم تغيير LoginScreen() إلى RoleSelectionScreen()
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

  static GetPage _scheduleRoute() {
    return GetPage(
      name: AppRoutes.SCHEDULE, //
      page: () => const AddEventScreen(), //
      transition: Transition.zoom, //
    );
  }

  static GetPage _profileRoute() {
    return GetPage(
      name: AppRoutes.PROFILE, //
      page: () => ProfileScreen(), //
      binding: ProfileBinding(), // <--- إضافة ProfileBinding هنا
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

  static GetPage _pdfScreenRoute() {
    return GetPage(
      name: AppRoutes.PDF_SCREEN, //
      page: () { //
        final title = Get.arguments as String; //
        return PdfScreen(title: title); //
      },
      binding: BindingsBuilder(() { //
        Get.lazyPut(() => DocumentProvider()); //
      }),
      transition: Transition.zoom, //
    );
  }

  static GetPage _pdfViewerRoute() {
    return GetPage(
      name: AppRoutes.PDF_VIEWER, //
      page: () { //
        final arguments = Get.arguments as Map<String, dynamic>; //
        final document = arguments['document']; //
        final collectionId = arguments['collectionId']; //
        return PdfViewerScreen( //
          document: document, //
          collectionId: collectionId, //
        );
      },
    );
  }

  static GetPage _videoScreen() {
    return GetPage(
      name: AppRoutes.VIDEO_SCREEN, //
      page: () => const VideoScreen(), //
    );
  }

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
}