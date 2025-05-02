import 'package:shared_preferences/shared_preferences.dart';

class AppInitializer {
  static Future<bool> isFirstRun() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isFirstRun') ?? true;
  }
}
