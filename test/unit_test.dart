// Unit tests for FCI App
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fci_app_new/styles/styles.dart';

void main() {
  setUpAll(() {
    // Initialize Flutter binding for Google Fonts
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  group('AppTextStyles Tests', () {
    testWidgets('headline1 should have correct properties',
        (WidgetTester tester) async {
      final style = AppTextStyles.headline1;

      expect(style.fontSize, equals(24));
      expect(style.fontWeight, equals(FontWeight.w700));
    });

    testWidgets('headline3 should have correct properties',
        (WidgetTester tester) async {
      final style = AppTextStyles.headline3;

      expect(style.fontSize, equals(18));
      expect(style.fontWeight, equals(FontWeight.w600));
    });

    testWidgets('bodyText should have correct properties',
        (WidgetTester tester) async {
      final style = AppTextStyles.bodyText;

      expect(style.fontSize, equals(22));
      expect(style.fontWeight, equals(FontWeight.w700));
    });
  });

  group('AppColors Tests', () {
    test('kPrimaryColor should be defined', () {
      expect(AppColors.primary, isNotNull);
    });

    test('white should be defined', () {
      expect(AppColors.white, isNotNull);
    });
  });

  group('AppSpacing Tests', () {
    test('spacing values should be correct', () {
      expect(AppSpacing.small, equals(8.0));
      expect(AppSpacing.medium, equals(16.0));
      expect(AppSpacing.large, equals(24.0));
      expect(AppSpacing.xLarge, equals(32.0));
    });
  });
}
