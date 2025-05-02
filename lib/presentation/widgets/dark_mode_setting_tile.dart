// lib/features/settings/presentation/widgets/dark_mode_setting_tile.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../data/providers/settings_provider.dart';

class DarkModeSettingTile extends StatelessWidget {
  const DarkModeSettingTile({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = context.watch<SettingsProvider>();
    
    return SwitchListTile(
      title: Text('6.4'.tr), // "الوضع المظلم
      value: settingsProvider.settings!.isDarkMode,
      onChanged: (value) => settingsProvider.toggleDarkMode(value),
      secondary: const Icon(Icons.dark_mode),
    );
  }
}