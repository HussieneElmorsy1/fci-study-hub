// lib/main.dart
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart'; // (متبقي لميزات أخرى مثل الدردشة)
import 'package:fci_app_new/app_pages/app_pages.dart'; //
import 'package:fci_app_new/app_pages/app_routes.dart'; //
import 'package:fci_app_new/data/api/api_service.dart'; //
import 'package:fci_app_new/data/datasources/remote/auth_remote_data_source.dart';
import 'package:fci_app_new/data/datasources/remote/academic_remote_data_source.dart';
import 'package:fci_app_new/data/providers/document_provider.dart'; //
// تم حذف: import 'package:fci_app_new/data/services/auth_service.dart';
import 'package:fci_app_new/domain/repository/auth_repository.dart'; //
import 'package:fci_app_new/domain/repository/auth_repository_impl.dart'; //
import 'package:fci_app_new/domain/repository/major_repository.dart';
import 'package:fci_app_new/domain/repository/major_repository_impl.dart';
import 'package:fci_app_new/domain/repository/profile_repository_impl.dart';
import 'package:fci_app_new/domain/repository/settings_repository_impl.dart'; //
import 'package:fci_app_new/domain/usecases/get_all_majors_use_case.dart';
import 'package:fci_app_new/domain/usecases/login_user.dart';
import 'package:fci_app_new/presentation/controllers/auth_controller.dart'; //
import 'package:fci_app_new/presentation/controllers/login_controller.dart'; //
import 'package:fci_app_new/presentation/controllers/majors_controller.dart';
import 'package:fci_app_new/presentation/controllers/profile_controller.dart'; // // استيراد ProfileController
import 'package:fci_app_new/domain/repository/profile_repository.dart'; // // استيراد ProfileRepository
import 'package:fci_app_new/presentation/screens/main_home_screen.dart'; //
import 'package:fci_app_new/presentation/screens/splash_screen.dart'; //
import 'package:fci_app_new/core/utils/app_initializer.dart'; //
import 'package:fci_app_new/core/utils/app_theme.dart'; //
import 'package:fci_app_new/data/datasources/locale/locale.dart'; //
import 'package:firebase_auth/firebase_auth.dart'; // (متبقي لميزات أخرى مثل الدردشة)
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/firebase_options.dart'; //
import 'data/providers/settings_provider.dart'; //

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }

  final sharedPreferences = await SharedPreferences.getInstance();
  final isFirstRun = await AppInitializer.isFirstRun();
  final isLoggedIn = sharedPreferences.getBool('isLoggedIn') ?? false;
  log('Main.dart - isLoggedIn (from SharedPreferences): $isLoggedIn');

  // Dependency Injection for API-based authentication
  Get.lazyPut<ApiService>(() => ApiService());
  Get.lazyPut<AuthRemoteDataSource>(
      () => AuthRemoteDataSource(Get.find<ApiService>()));
  Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(Get.find<AuthRemoteDataSource>()));
  Get.lazyPut<LoginUser>(() => LoginUser(Get.find<AuthRepository>()));
  Get.lazyPut<AuthController>(
      () => AuthController(Get.find<LoginUser>(), Get.find<AuthRepository>()));
  Get.lazyPut<ProfileController>(() => ProfileController(
      Get.find<ProfileRepository>(), Get.find<AuthRepository>()));

  // تسجيل ProfileRepositoryImpl
  Get.lazyPut<ProfileRepository>(
      () => ProfileRepositoryImpl(Get.find<ApiService>()));

  // Global dependency injection for Majors functionality
  Get.lazyPut<AcademicRemoteDataSource>(
      () => AcademicRemoteDataSource(Get.find<ApiService>()));
  Get.lazyPut<MajorRepository>(
      () => MajorRepositoryImpl(Get.find<AcademicRemoteDataSource>()));
  Get.lazyPut<GetAllMajorsUseCase>(
      () => GetAllMajorsUseCase(Get.find<MajorRepository>()));
  Get.lazyPut<MajorsController>(
      () => MajorsController(Get.find<GetAllMajorsUseCase>()));

  // لا نحتاج لـ lazyPut ProfileController هنا، سيتم تهيئته عبر ProfileBinding
  // Get.lazyPut<ProfileController>(() => ProfileController(Get.find<ProfileRepository>(), Get.find<AuthRepository>()));

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DocumentProvider()),
        ChangeNotifierProvider(
          create: (_) => SettingsProvider(
            repository: SettingsRepositoryImpl(prefs: sharedPreferences),
          )..loadSettings(),
        ),
      ],
      child: MyApp(
        isFirstRun: isFirstRun,
        isLoggedIn: isLoggedIn,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isFirstRun;
  final bool isLoggedIn;

  MyApp({super.key, required this.isFirstRun, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);

    String initialRoute = AppRoutes.SPLASH;
    if (!isFirstRun && !isLoggedIn) {
      initialRoute = AppRoutes.ROLE_SELECTION;
    } else if (isLoggedIn) {
      initialRoute = AppRoutes.MAIN_HOME_SCREEN;
    }

    return GetMaterialApp(
      locale: Get.deviceLocale,
      translations: MyLocale(),
      fallbackLocale: const Locale('ar', 'SA'),
      title: 'FCI App',
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: settingsProvider.settings?.isDarkMode ?? false
          ? ThemeMode.dark
          : ThemeMode.light,
      initialRoute: initialRoute,
      getPages: AppPages.routes,
    );
  }
}
