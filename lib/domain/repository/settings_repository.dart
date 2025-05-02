// lib/features/settings/domain/repositories/settings_repository.dart
import '../../data/models/settings.dart';

abstract class SettingsRepository {
  Future<Settings> getSettings();
  Future<void> saveSettings(Settings settings);
}