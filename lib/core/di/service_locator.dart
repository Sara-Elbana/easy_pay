import 'package:dio/dio.dart';
import 'package:easy_pay_app/features/account_and_card/data/datasources/account_remote_data_source.dart';
import 'package:easy_pay_app/features/account_and_card/data/datasources/add_card_remote_data_source.dart';
import 'package:easy_pay_app/features/account_and_card/data/datasources/card_remote_data_source.dart';
import 'package:easy_pay_app/features/account_and_card/data/repository_impl/account_repository_impl.dart';
import 'package:easy_pay_app/features/account_and_card/data/repository_impl/card_repository_impl.dart';
import 'package:easy_pay_app/features/account_and_card/domain/repository_interface/account_repository_interface.dart';
import 'package:easy_pay_app/features/account_and_card/domain/repository_interface/card_repository_interface.dart';
import 'package:easy_pay_app/features/account_and_card/domain/use_cases/add_card_use_case.dart';
import 'package:easy_pay_app/features/account_and_card/domain/use_cases/delete_card_use_case.dart';
import 'package:easy_pay_app/features/account_and_card/domain/use_cases/get_accounts_use_case.dart';
import 'package:easy_pay_app/features/account_and_card/domain/use_cases/get_cardss_use_case.dart';
import 'package:easy_pay_app/features/account_and_card/presentation/cubit/account_cubit.dart';
import 'package:easy_pay_app/features/account_and_card/presentation/cubit/card_cubit.dart';
import 'package:easy_pay_app/features/app_information/data/data_source/app_info_remote_dataSource.dart';
import 'package:easy_pay_app/features/app_information/data/repository_impl/app_info_repository_impl.dart';
import 'package:easy_pay_app/features/app_information/domain/repository_interface/app_info_repository.dart';
import 'package:easy_pay_app/features/app_information/domain/use_case/get_app_info_use_case.dart';
import 'package:easy_pay_app/features/app_information/presentation/cubit/app_info_cubit.dart';
import 'package:easy_pay_app/features/auth/data/data_source/auth_remote_datasource.dart';
import 'package:easy_pay_app/features/auth/data/repository_impl/auth_repository_impl.dart';
import 'package:easy_pay_app/features/auth/data/repository_impl/biometric_repository_impl.dart';
import 'package:easy_pay_app/features/auth/domain/repository_interface/auth_repository.dart';
import 'package:easy_pay_app/features/auth/domain/repository_interface/biometric_repository.dart';
import 'package:easy_pay_app/features/auth/domain/use_cases/biometric_usecase.dart';
import 'package:easy_pay_app/features/auth/domain/use_cases/sign_in_usecase.dart';
import 'package:easy_pay_app/features/auth/domain/use_cases/sign_up_usecase.dart';
import 'package:easy_pay_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:easy_pay_app/features/profile/data/data_sources/profile_remote_data_source.dart';
import 'package:easy_pay_app/features/profile/data/repository_impl/profile_repository_impl.dart';
import 'package:easy_pay_app/features/profile/domain/repository_interface/profile_repository_interface.dart';
import 'package:easy_pay_app/features/profile/domain/use_cases/get_profile_use_case.dart';
import 'package:easy_pay_app/features/profile/presentation/cubit/profile_cubit.dart';
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
import '../../features/beneficiary/domain/repositories/beneficiary_repository.dart';
import '../../features/beneficiary/data/repositories/beneficiary_repository_impl.dart';
import '../../features/beneficiary/domain/usecases/get_beneficiaries_usecase.dart';
import '../../features/transfer/domain/usecases/execute_transfer_usecase.dart';
import '../../features/beneficiary/domain/usecases/save_beneficiary_usecase.dart';
import '../../features/transfer/presentation/cubit/transfer_cubit.dart';
import '../../features/beneficiary/presentation/cubit/beneficiary_cubit.dart';
import 'package:easy_pay_app/features/withdraw/domain/repositories/withdraw_repository.dart';
import 'package:easy_pay_app/features/withdraw/domain/usecases/execute_withdraw_usecase.dart';
import 'package:easy_pay_app/features/withdraw/data/repositories/withdraw_repository_impl.dart';
import 'package:easy_pay_app/features/withdraw/presentation/cubit/withdraw_cubit.dart';
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

import 'package:easy_pay_app/features/auth/domain/use_cases/reset_password_usecase.dart';
import 'package:easy_pay_app/features/auth/domain/use_cases/send_otp_usecase.dart';
import 'package:easy_pay_app/features/auth/domain/use_cases/sign_out_usecase.dart';
import 'package:easy_pay_app/features/auth/domain/use_cases/verify_otp_usecase.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  final prefs = SharedPreferencesService();
  await prefs.init();
  getIt.registerSingleton<SharedPreferencesService>(prefs);

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

  // Data Source
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(dio: getIt()),
  );

  // Repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: getIt(),
      secureStorageService: getIt(),
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
    () => SendOtpUseCase(getIt()),
  );

  getIt.registerLazySingleton(
    () => VerifyOtpUseCase(getIt()),
  );

  getIt.registerLazySingleton(
    () => ResetPasswordUseCase(getIt()),
  );

  getIt.registerLazySingleton(
    () => SignOutUseCase(getIt()),
  );

  getIt.registerLazySingleton(
    () => LocalAuthentication(),
  );

  getIt.registerLazySingleton(
    () => BiometricService(getIt()),
  );
  getIt.registerLazySingleton(
    () => MediaService(),
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

  // Cubits
  getIt.registerFactory<OnboardingCubit>(
    () => OnboardingCubit(totalPages: 3),
  );
  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(
      signInUseCase: getIt(),
      signUpUseCase: getIt(),
      biometricUseCase: getIt(),
      signOutUseCase: getIt(),
    ),
  );
  getIt.registerFactory<ForgotPasswordCubit>(
    () => ForgotPasswordCubit(
      sendOtpUseCase: getIt(),
      verifyOtpUseCase: getIt(),
      resetPasswordUseCase: getIt(),
    ),
  );

  // Transfer Feature
  getIt.registerLazySingleton<TransferRepository>(
    () => TransferRepositoryImpl(),
  );
  getIt.registerLazySingleton(
    () => GetCardsUseCase(getIt()),
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

  // Beneficiary Feature
  getIt.registerLazySingleton<BeneficiaryRepository>(
    () => BeneficiaryRepositoryImpl(),
  );
  getIt.registerLazySingleton(
    () => GetBeneficiariesUseCase(getIt()),
  );
  getIt.registerLazySingleton(
    () => SaveBeneficiaryUseCase(getIt()),
  );
  getIt.registerFactory<BeneficiaryCubit>(
    () => BeneficiaryCubit(
      getBeneficiariesUseCase: getIt(),
      saveBeneficiaryUseCase: getIt(),
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
  // Withdraw Feature
  getIt.registerLazySingleton<WithdrawRepository>(
    () => WithdrawRepositoryImpl(),
  );
  getIt.registerLazySingleton(
    () => ExecuteWithdrawUseCase(getIt()),
  );
  getIt.registerFactory<WithdrawCubit>(
    () => WithdrawCubit(
      executeWithdrawUseCase: getIt(),
    ),
  );

  getIt.registerFactory(() => MapCubit(
      getAutocompleteUseCase: getIt(), getPlaceDetailsUseCase: getIt()));
  getIt.registerLazySingleton(() => GetAutocompleteUseCase(getIt()));
  getIt.registerLazySingleton(() => GetPlaceDetailsUseCase(getIt()));
  getIt.registerLazySingleton<MapRepository>(() => MapRepositoryImpl(getIt()));
  getIt.registerLazySingleton<MapRemoteDataSource>(
      () => MapRemoteDataSourceImpl(getIt()));

  // App Information Feature
  getIt.registerLazySingleton<AppInfoRemoteDataSource>(
    () => AppInfoRemoteDataSource(),
  );

  getIt.registerLazySingleton<AppInfoRepository>(
    () => AppInfoRepositoryImpl(remoteDataSource: getIt()),
  );

  getIt.registerLazySingleton(
    () => GetAppInfoUseCase(getIt()),
  );

  getIt.registerFactory<AppInfoCubit>(
    () => AppInfoCubit(getIt()),
  );
  // Profile Feature
  getIt.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSource(),
  );

  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(remoteDataSource: getIt()),
  );

  getIt.registerLazySingleton(
    () => GetProfileUseCase(getIt()),
  );

  getIt.registerFactory<ProfileCubit>(
    () => ProfileCubit(getIt()),
  );

  // Account & Card Feature
  getIt.registerLazySingleton<AccountRemoteDataSource>(
        () => AccountRemoteDataSource(),
  );
  getIt.registerLazySingleton<AccountRepository>(
        () => AccountRepositoryImpl(remoteDataSource: getIt()),
  );
  getIt.registerLazySingleton(
        () => GetAccountsUseCase(getIt()),
  );
  getIt.registerFactory<AccountCubit>(
        () => AccountCubit(getAccountsUseCase: getIt()),
  );

  getIt.registerLazySingleton<CardRemoteDataSource>(
        () => CardRemoteDataSource(),
  );

  getIt.registerLazySingleton<CardRepository>(
        () => CardRepositoryImpl(getIt(), getIt()),
  );

  getIt.registerLazySingleton(
        () => GetCardssUseCase(getIt()),
  );

  getIt.registerLazySingleton(() => AddCardUseCase(getIt()));
  getIt.registerLazySingleton(() => DeleteCardUseCase(getIt()));
  getIt.registerFactory(
        () => CardCubit(getIt(), getIt(),getIt()),
  );
  getIt.registerLazySingleton<AddCardRemoteDataSource>(
        () => AddCardRemoteDataSource(),
  );

}
