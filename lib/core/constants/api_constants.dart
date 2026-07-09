class ApiConstants {
  // API Base Configuration
  static const String baseUrl = 'https://api.example.com';
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
  static const String loginEndpoint = '/auth/login';
  static const String logoutEndpoint = '/auth/logout';
  static const String refreshTokenEndpoint = '/auth/refresh';

  // User
  static const String userProfileEndpoint = '/users/profile';
  static const String updateProfileEndpoint = '/users/profile';

  // Add more endpoints as needed

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
