class ApiConstants {
  // API Base Configuration
  static const String baseUrl = 'https://ebank.dotlaa.com/api';
  static const String apiVersion = 'v1';

  // Timeouts (in seconds)
  static const int connectionTimeout = 30;
  static const int receiveTimeout = 30;
  static const int sendTimeout = 30;

  // Token & Security
  static const int tokenExpirationTime = 3600; // 1 hour in seconds
  static const int refreshTokenBuffer =
      300; // Refresh 5 minutes before expiration

  // Endpoints
  // Authentication
  static const String registerEndpoint = '/register';
  static const String loginEndpoint = '/login';
  static const String logoutEndpoint = '/logout';
  static const String refreshTokenEndpoint = '/auth/refresh';
  static const String forgotPasswordSendEndpoint = '/forgot-password/send';
  static const String forgotPasswordVerifyEndpoint = '/forgot-password/verify';
  static const String forgotPasswordResetEndpoint = '/forgot-password/reset';

  // User
  static const String userProfileEndpoint = '/users/profile';
  static const String updateProfileEndpoint = '/users/profile';



  // ApiBank Public Endpoints
  static const String branchesEndpoint = '/branches';
  static const String interestRatesEndpoint = '/interest-rates';
  static const String exchangeRatesEndpoint = '/exchange-rates';
  static const String convertCurrencyEndpoint = '/exchange/convert';
  static const String externalBanksEndpoint = '/external-banks';
  static const String appInfoEndpoint = '/app-info';
  static const String savingsTermsEndpoint = '/savings/terms';
  static const String profileEndpoint = '/profile';
  static const String accountsEndpoint = '/accounts';
  static const String cardsEndpoint = '/cards';
  static const String notificationsEndpoint = '/notifications';
  static const String chatEndpoint = '/notifications/reply';




  // HTTP Headers
  static const String contentTypeJson = 'application/json';
  static const String authorizationHeader = 'Authorization';
  static const String bearerPrefix = 'Bearer';

  // Error Messages
  static const String unknownError = 'An unknown error occurred';
  static const String networkError = 'Network connection failed';
  static const String timeoutError = 'Request timeout. Please try again';
  static const String unauthorizedError = 'Unauthorized access';
  static const String forbiddenError = 'Access forbidden';
  static const String serverError = 'Server error. Please try again later';
}
