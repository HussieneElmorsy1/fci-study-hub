import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fci_app_new/app_pages/app_pages.dart';
import 'package:fci_app_new/app_pages/app_routes.dart';
import 'package:fci_app_new/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:fci_app_new/data/providers/document_provider.dart';
import 'package:fci_app_new/data/services/auth_service.dart';
import 'package:fci_app_new/domain/repository/auth_repository.dart';
import 'package:fci_app_new/domain/repository/auth_repository_impl.dart';
import 'package:fci_app_new/domain/repository/settings_repository_impl.dart';
import 'package:fci_app_new/presentation/controllers/auth_controller.dart';
import 'package:fci_app_new/presentation/controllers/login_controller.dart';
import 'package:fci_app_new/presentation/screens/login_screen.dart';
import 'package:fci_app_new/presentation/screens/main_home_screen.dart';
import 'package:fci_app_new/presentation/screens/splash_screen.dart';
import 'package:fci_app_new/core/utils/app_initializer.dart';
import 'package:fci_app_new/core/utils/app_theme.dart';
import 'package:fci_app_new/data/data_sources/locale/locale.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/firebase_options.dart';
import 'data/providers/settings_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Firebase.apps.isEmpty) {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}


  // ضبط الـ Persistence لـ Firebase Auth
  if (GetPlatform.isWeb) {
    await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
  }

  // التأكد من أن Firebase Auth جاهز
  await FirebaseAuth.instance.authStateChanges().first;

  final sharedPreferences = await SharedPreferences.getInstance();
  final isFirstRun = await AppInitializer.isFirstRun();
  final isLoggedIn = sharedPreferences.getBool('isLoggedIn') ?? false;
  log('Main.dart - isLoggedIn: $isLoggedIn');
  log('Main.dart - Firebase currentUser: ${FirebaseAuth.instance.currentUser?.uid}');

  // Dependency Injection
  Get.lazyPut<AuthRemoteDataSource>(() => AuthRemoteDataSource());
  Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(Get.find()));
  Get.lazyPut<AuthService>(() => AuthService(Get.find()));
  Get.lazyPut<AuthController>(() => AuthController(Get.find()));
  Get.lazyPut<LoginController>(() => LoginController());

   // تحديث حالة المستخدم (أونلاين/أوفلاين)
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user != null) {
      FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'isOnline': true,
        'lastSeen': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      // لما المستخدم يقفل التطبيق، يتحدث حالته لأوفلاين
      FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'isOnline': false,
        'lastSeen': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    }
  });

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
      initialRoute: AppRoutes.SPLASH,
      getPages: AppPages.routes,
    );
  }
}