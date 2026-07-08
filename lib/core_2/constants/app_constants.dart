class AppConstants {
  // App Metadata
  static const String appName = 'Task App';
  static const String appVersion = '1.0.0';

  // Cache Keys
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userIdKey = 'user_id';
  static const String languageKey = 'language';
  static const String themeModeKey = 'theme_mode';
  static const String isFirstLaunchKey = 'is_first_launch';
  static const String isOnboardingCompletedKey = 'is_onboarding_completed';

  // Validation Limits
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 128;
  static const int maxEmailLength = 254;
  static const int minPhoneLength = 10;
  static const int maxPhoneLength = 15;

  // Amount Limits for Banking
  static const double minTransactionAmount = 0.01;
  static const double maxTransactionAmount = 999999.99;
  static const int maxDecimalPlaces = 2;

  // Retry Policy
  static const int maxRetries = 3;
  static const int retryDelayMs = 1000;

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
}
