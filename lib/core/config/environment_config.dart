import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvironmentConfig {
  static String get baseUrl =>
      dotenv.env['BASE_URL'] ?? '';

  static String get appName =>
      dotenv.env['APP_NAME'] ?? '';

  static String get apiKey =>
      dotenv.env['API_KEY'] ?? '';
}