enum AppEnvironment {
  dev,
  staging,
  prod,
}

class AppConfig {
  final AppEnvironment environment;
  final String appName;
  final String baseUrl;
  final bool enableLogging;

  const AppConfig({
    required this.environment,
    required this.appName,
    required this.baseUrl,
    required this.enableLogging,
  });

  static const AppConfig dev = AppConfig(
    environment: AppEnvironment.dev,
    appName: 'EasyBay Development',
    baseUrl: 'https://ebank.dotlaa.com/api',
    enableLogging: true,
  );

  static const AppConfig staging = AppConfig(
    environment: AppEnvironment.staging,
    appName: 'EasyBay Stage',
    baseUrl: 'https://ebank.dotlaa.com/api',
    enableLogging: true,
  );

  static const AppConfig prod = AppConfig(
    environment: AppEnvironment.prod,
    appName: 'EasyBay Production',
    baseUrl: 'https://ebank.dotlaa.com/api',
    enableLogging: false,
  );

  bool get isDev => environment == AppEnvironment.dev;
  bool get isStaging => environment == AppEnvironment.staging;
  bool get isProd => environment == AppEnvironment.prod;
}
