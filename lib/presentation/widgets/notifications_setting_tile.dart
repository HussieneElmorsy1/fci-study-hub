// lib/features/settings/presentation/widgets/notifications_setting_tile.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../data/providers/settings_provider.dart';

class NotificationsSettingTile extends StatelessWidget {
  const NotificationsSettingTile({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = context.watch<SettingsProvider>();
    
    return SwitchListTile(
      title: Text('6.5'.tr), // إشعارات التطبيق
      value: settingsProvider.settings!.areNotificationsEnabled,
      onChanged: (value) => settingsProvider.toggleNotifications(value),
      secondary: const Icon(Icons.notifications),
    );
  }
}