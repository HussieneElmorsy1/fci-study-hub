// lib/features/settings/data/repositories/settings_repository_impl.dart
import 'package:fci_app_new/domain/repository/settings_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/settings.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SharedPreferences prefs;

  SettingsRepositoryImpl({required this.prefs});

  @override
  Future<Settings> getSettings() async {
    return Settings(
      isDarkMode: prefs.getBool('isDarkMode') ?? false,
      areNotificationsEnabled: prefs.getBool('areNotificationsEnabled') ?? true,
    );
  }

  @override
  Future<void> saveSettings(Settings settings) async {
    await prefs.setBool('isDarkMode', settings.isDarkMode);
    await prefs.setBool('areNotificationsEnabled', settings.areNotificationsEnabled);
  }
}