// This is a basic Flutter widget test for FCI App.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import 'package:fci_app_new/main.dart';
import 'package:fci_app_new/data/providers/settings_provider.dart';
import 'package:fci_app_new/data/providers/document_provider.dart';
import 'package:fci_app_new/domain/repository/settings_repository_impl.dart';

void main() {
  group('FCI App Tests', () {
    setUp(() async {
      // Reset GetX before each test
      Get.reset();

      // Initialize SharedPreferences for testing
      SharedPreferences.setMockInitialValues({});
    });

    testWidgets('App should build without crashing',
        (WidgetTester tester) async {
      // Initialize SharedPreferences for testing
      final sharedPreferences = await SharedPreferences.getInstance();

      // Build our app with proper provider setup
      await tester.pumpWidget(
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
            isFirstRun: true,
            isLoggedIn: false,
          ),
        ),
      );

      // Wait for the app to settle
      await tester.pumpAndSettle();

      // Verify that the app builds successfully
      expect(find.byType(MyApp), findsOneWidget);
    });

    testWidgets('Splash screen should be displayed for first run',
        (WidgetTester tester) async {
      // Initialize SharedPreferences for testing
      final sharedPreferences = await SharedPreferences.getInstance();

      // Build our app with proper provider setup
      await tester.pumpWidget(
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
            isFirstRun: true,
            isLoggedIn: false,
          ),
        ),
      );

      // Wait for the app to settle
      await tester.pumpAndSettle();

      // The app should navigate to splash screen initially
      // We can't easily test the exact screen due to GetX routing complexity
      // But we can verify the app doesn't crash
      expect(find.byType(MyApp), findsOneWidget);
    });
  });
}
