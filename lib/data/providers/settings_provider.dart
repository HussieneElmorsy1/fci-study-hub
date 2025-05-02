// lib/features/settings/presentation/providers/settings_provider.dart
import 'package:flutter/material.dart';

import '../models/settings.dart';
import '../../domain/repository/settings_repository.dart';

class SettingsProvider extends ChangeNotifier {
  final SettingsRepository repository;
  Settings? _settings;

  Settings? get settings => _settings;

  SettingsProvider({required this.repository});

  Future<void> loadSettings() async {
    _settings = await repository.getSettings();
    notifyListeners();
  }

  Future<void> toggleDarkMode(bool value) async {
    _settings = _settings?.copyWith(isDarkMode: value);
    await repository.saveSettings(_settings!);
    notifyListeners();
  }

  Future<void> toggleNotifications(bool value) async {
    _settings = _settings?.copyWith(areNotificationsEnabled: value);
    await repository.saveSettings(_settings!);
    notifyListeners();
  }
}