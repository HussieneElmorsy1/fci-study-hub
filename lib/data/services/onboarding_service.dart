import 'package:shared_preferences/shared_preferences.dart';

class OnboardingService { 
  // Service to manage onboarding state

  static Future<bool> isOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("onboarding_completed") ?? false;
  }
}
