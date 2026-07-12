import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/presentation/cubit/sign_in_cubit.dart';
import '../../features/auth/presentation/cubit/forgot_password_cubit.dart';
import '../../features/onboarding/presentation/cubit/onboarding_cubit.dart';
import '../network/network.dart';
import '../services/services.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
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

  // Cubits
  getIt.registerFactory<OnboardingCubit>(
    () => OnboardingCubit(totalPages: 3),
  );
  getIt.registerFactory<SignInCubit>(
    () => SignInCubit(),
  );
  getIt.registerFactory<ForgotPasswordCubit>(
    () => ForgotPasswordCubit(),
  );
}
