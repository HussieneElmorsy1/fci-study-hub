class Settings {
  final bool isDarkMode;
  final bool areNotificationsEnabled;

  const Settings({
    required this.isDarkMode,
    required this.areNotificationsEnabled,
  });

  Settings copyWith({
    bool? isDarkMode,
    bool? areNotificationsEnabled,
  }) {
    return Settings(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      areNotificationsEnabled: areNotificationsEnabled ?? this.areNotificationsEnabled,
    );
  }
}