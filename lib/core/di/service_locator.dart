import 'package:dio/dio.dart';
import 'package:easy_pay_app/features/Branch/data/datasources/map_remote_data_source.dart';
import 'package:easy_pay_app/features/Branch/data/repositories/map_repository_impl.dart';
import 'package:easy_pay_app/features/Branch/domain/repositories/map_repository.dart';
import 'package:easy_pay_app/features/Branch/domain/usecases/get_autocomplete_usecase.dart';
import 'package:easy_pay_app/features/Branch/presentation/cubit/map_cubit.dart';
import 'package:easy_pay_app/features/auth/data/data_source/auth_remote_datasource.dart';
import 'package:easy_pay_app/features/auth/data/repository_impl/auth_repository_impl.dart';
import 'package:easy_pay_app/features/auth/data/repository_impl/biometric_repository_impl.dart';
import 'package:easy_pay_app/features/auth/domain/repository_interface/auth_repository.dart';
import 'package:easy_pay_app/features/auth/domain/repository_interface/biometric_repository.dart';
import 'package:easy_pay_app/features/auth/domain/use_cases/biometric_usecase.dart';
import 'package:easy_pay_app/features/auth/domain/use_cases/sign_in_usecase.dart';
import 'package:easy_pay_app/features/auth/domain/use_cases/sign_up_usecase.dart';
import 'package:easy_pay_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:local_auth/local_auth.dart';

import '../../features/auth/presentation/cubit/forgot_password_cubit.dart';
import '../../features/onboarding/presentation/cubit/onboarding_cubit.dart';
import '../network/network.dart';
import '../services/services.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  final prefs = SharedPreferencesService();
  await prefs.init();
  getIt.registerSingleton<SharedPreferencesService>(prefs);
  // Data Source
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );

// Repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: getIt(),
    ),
  );

// Use Cases
  getIt.registerLazySingleton(
    () => SignInUseCase(getIt()),
  );

  getIt.registerLazySingleton(
    () => SignUpUseCase(getIt()),
  );

  getIt.registerLazySingleton(
    () => LocalAuthentication(),
  );

  getIt.registerLazySingleton<BiometricRepository>(
    () => BiometricRepositoryImpl(
      getIt(),
    ),
  );

  getIt.registerLazySingleton(
    () => BiometricUseCase(
      getIt(),
    ),
  );

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
  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(
      signInUseCase: getIt(),
      signUpUseCase: getIt(),
      biometricUseCase: getIt(),
    ),
  );
  getIt.registerFactory<ForgotPasswordCubit>(
    () => ForgotPasswordCubit(),
  );
  getIt.registerFactory(() => MapCubit(
      getAutocompleteUseCase: getIt(), getPlaceDetailsUseCase: getIt()));
  getIt.registerLazySingleton(() => GetAutocompleteUseCase(getIt()));
  getIt.registerLazySingleton(() => GetPlaceDetailsUseCase(getIt()));
  getIt.registerLazySingleton<MapRepository>(() => MapRepositoryImpl(getIt()));
  getIt.registerLazySingleton<MapRemoteDataSource>(
      () => MapRemoteDataSourceImpl(getIt()));
}
