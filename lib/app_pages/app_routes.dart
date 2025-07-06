/// This class defines the routes used in the application.
abstract class AppRoutes {
  /// The splash screen route.
  static const SPLASH = '/';

  /// The onboarding screen route.
  static const ONBOARDING = '/onboarding';

  /// The route that decides between onboarding or home screen.
  static const ONBOARDING_OR_HOME = '/onboarding_or_home';

  /// The login screen route.
  static const LOGIN = '/login';

  /// The home screen route.
  static const  MAIN_HOME_SCREEN = '/main_home';
  
  static const HOME_SCREEN = '/home';

  /// The forgot password screen route.
  static const FORGOT_PASSWORD = '/forgot_password';

  /// The schedule screen route.
  static const String SCHEDULE = '/schedule';

  /// The profile screen route.
  static const String PROFILE = '/profile';

  /// The more options screen route.
  static const String MORE = '/more';

  /// The PDF screen route.
  static const String PDF_SCREEN = '/pdf_screen';

  /// The PDF viewer screen route.
  static const String PDF_VIEWER = '/pdf_viewer';

  /// The video screen route.
  static const String VIDEO_SCREEN = '/video_screen';
  /// The chats screen route.
  static const String CHATS = '/chats';
  /// The chat screen route.
  static const String CHAT = '/chat';
  /// The role selection screen route.
  static const String ROLE_SELECTION = '/role_selection';
}
