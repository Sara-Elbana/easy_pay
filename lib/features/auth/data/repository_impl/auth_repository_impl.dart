import 'package:easy_pay_app/core/services/secure_storage_service.dart';
import 'package:easy_pay_app/features/auth/data/data_source/auth_remote_datasource.dart';
import 'package:easy_pay_app/features/auth/domain/entities/user_entity.dart';
import 'package:easy_pay_app/features/auth/domain/repository_interface/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final SecureStorageService secureStorageService;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.secureStorageService,
  });

  @override
  Future<UserEntity> signIn(String phoneNumber, String password) async {
    final userModel = await remoteDataSource.signIn(phoneNumber, password);
    if (userModel.accessToken != null && userModel.accessToken!.isNotEmpty) {
      await secureStorageService.saveAccessToken(userModel.accessToken!);
    }
    if (userModel.refreshToken != null && userModel.refreshToken!.isNotEmpty) {
      await secureStorageService.saveRefreshToken(userModel.refreshToken!);
    }
    return userModel;
  }

  @override
  Future<UserEntity> signUp(
      String name, String phoneNumber, String password) async {
    final userModel = await remoteDataSource.signUp(name, phoneNumber, password);
    if (userModel.accessToken != null && userModel.accessToken!.isNotEmpty) {
      await secureStorageService.saveAccessToken(userModel.accessToken!);
    }
    if (userModel.refreshToken != null && userModel.refreshToken!.isNotEmpty) {
      await secureStorageService.saveRefreshToken(userModel.refreshToken!);
    }
    return userModel;
  }

  @override
  Future<void> sendOtp(String phoneNumber) async {
    await remoteDataSource.sendOtp(phoneNumber);
  }

  @override
  Future<void> verifyOtp(String phoneNumber, String code) async {
    await remoteDataSource.verifyOtp(phoneNumber, code);
  }

  @override
  Future<void> resetPassword(
      String phoneNumber, String code, String newPassword) async {
    await remoteDataSource.resetPassword(phoneNumber, code, newPassword);
  }

  @override
  Future<void> signOut() async {
    try {
      await remoteDataSource.signOut();
    } finally {
      await secureStorageService.clearSensitiveData();
    }
  }
}
