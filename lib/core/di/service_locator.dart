import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../network/network.dart';
import '../services/services.dart';

final getIt = GetIt.instance;

/// Initialize all dependencies
Future<void> setupDependencies() async {
  // Initialize services first
  final prefs = SharedPreferencesService();
  await prefs.init();
  getIt.registerSingleton<SharedPreferencesService>(prefs);

  const secureStorage = SecureStorageService();
  getIt.registerSingleton<SecureStorageService>(secureStorage);

  getIt.registerSingleton<NetworkConnectivityService>(
    NetworkConnectivityService(),
  );

  // Register Dio
  final dio = DioClient.createDioClient();
  getIt.registerSingleton<Dio>(dio);
}
