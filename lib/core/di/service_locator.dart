import 'package:dio/dio.dart';
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
import 'package:easy_pay_app/features/Branch/data/datasources/map_remote_data_source.dart';
import 'package:easy_pay_app/features/Branch/data/repositories/map_repository_impl.dart';
import 'package:easy_pay_app/features/Branch/domain/repositories/map_repository.dart';
import 'package:easy_pay_app/features/Branch/domain/usecases/get_autocomplete_usecase.dart';
import 'package:easy_pay_app/features/Branch/presentation/cubit/map_cubit.dart';
import '../../features/auth/presentation/cubit/forgot_password_cubit.dart';
import '../../features/onboarding/presentation/cubit/onboarding_cubit.dart';
import '../../features/transfer/domain/repositories/transfer_repository.dart';
import '../../features/transfer/data/repositories/transfer_repository_impl.dart';
import '../../features/transfer/domain/usecases/get_cards_usecase.dart';
import '../../features/transfer/domain/usecases/get_beneficiaries_usecase.dart';
import '../../features/transfer/domain/usecases/execute_transfer_usecase.dart';
import '../../features/transfer/presentation/cubit/transfer_cubit.dart';
import '../network/network.dart';
import '../services/services.dart';
import 'package:easy_pay_app/features/exchange_rate/data/data_source/exchange_rate_remote_datasource.dart';
import 'package:easy_pay_app/features/exchange_rate/data/repositories/exchange_rate_repository_impl.dart';
import 'package:easy_pay_app/features/exchange_rate/domain/repositories/exchange_rate_repository.dart';
import 'package:easy_pay_app/features/exchange_rate/presentation/cubit/exchange_rate_cubit.dart';
import 'package:easy_pay_app/features/exchange/data/data_sources/exchange_remote_data_source.dart';
import 'package:easy_pay_app/features/exchange/data/repositories/exchange_repository_impl.dart';
import 'package:easy_pay_app/features/exchange/domain/repositories/exchange_repository.dart';
import 'package:easy_pay_app/features/exchange/presentation/cubit/exchange_cubit.dart';

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

  getIt.registerLazySingleton(
        () => BiometricService(getIt()),
  );

//// Biometric
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


  /// secure storage
  const secureStorage = SecureStorageService();
  getIt.registerSingleton<SecureStorageService>(secureStorage);

  /// NetworkConnectivityService
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

  // Transfer Feature
  getIt.registerLazySingleton<TransferRepository>(
        () => TransferRepositoryImpl(),
  );
  getIt.registerLazySingleton(
        () => GetCardsUseCase(getIt()),
  );
  getIt.registerLazySingleton(
        () => GetBeneficiariesUseCase(getIt()),
  );
  getIt.registerLazySingleton(
        () => ExecuteTransferUseCase(getIt()),
  );
  getIt.registerFactory<TransferCubit>(
        () => TransferCubit(
      getCardsUseCase: getIt(),
      getBeneficiariesUseCase: getIt(),
      executeTransferUseCase: getIt(),
      biometricService: getIt(),
    ),
  );

  // Exchange Rate Feature
  getIt.registerLazySingleton<ExchangeRateRemoteDataSource>(
        () => ExchangeRateRemoteDataSourceImpl(),
  );
  getIt.registerLazySingleton<ExchangeRateRepository>(
        () => ExchangeRateRepositoryImpl(remoteDataSource: getIt()),
  );
  getIt.registerFactory<ExchangeRateCubit>(
        () => ExchangeRateCubit(repository: getIt()),
  );

  // Exchange Feature
  getIt.registerLazySingleton<ExchangeRemoteDataSource>(
        () => ExchangeRemoteDataSourceImpl(),
  );
  getIt.registerLazySingleton<ExchangeRepository>(
        () => ExchangeRepositoryImpl(remoteDataSource: getIt()),
  );
  getIt.registerFactory<ExchangeCubit>(
        () => ExchangeCubit(repository: getIt()),
  );
  getIt.registerFactory(() => MapCubit(
      getAutocompleteUseCase: getIt(), getPlaceDetailsUseCase: getIt()));
  getIt.registerLazySingleton(() => GetAutocompleteUseCase(getIt()));
  getIt.registerLazySingleton(() => GetPlaceDetailsUseCase(getIt()));
  getIt.registerLazySingleton<MapRepository>(() => MapRepositoryImpl(getIt()));
  getIt.registerLazySingleton<MapRemoteDataSource>(
          () => MapRemoteDataSourceImpl(getIt()));
}
