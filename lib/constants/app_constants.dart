class AppConstants {
  // App Information
  static const String appName = 'News Portal';
  static const String appVersion = '1.0.0';

  // API Endpoints (placeholder - replace with actual API)
  static const String baseUrl =
      'https://newsdata.io/api/1/latest?apikey=pub_48b058dfa014468187463f5e697fa782&q=all%20news%20political%20economic%20health%20sports';
  static const String newsEndpoint = '/api/news';
  static const String authEndpoint = '/api/auth';

  // Storage Keys
  static const String themeKey = 'theme_mode';
  static const String languageKey = 'language_code';
  static const String userTokenKey = 'user_token';

  // News Categories
  static const List<String> newsCategories = [
    'all',
    'political',
    'economic',
    'sports',
    'technology',
    'entertainment',
    'health',
    'education',
  ];

  // UI Constants
  static const double defaultPadding = 16.0;
  static const double defaultBorderRadius = 12.0;
  static const double defaultElevation = 4.0;

  // Animation Durations
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 500);
  static const Duration longAnimationDuration = Duration(milliseconds: 800);

  // OTP Constants
  static const int otpLength = 6;
  static const Duration otpResendTimeout = Duration(seconds: 30);

  // Pagination
  static const int newsPerPage = 20;
}
