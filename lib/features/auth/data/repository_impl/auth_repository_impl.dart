import 'package:easy_pay_app/core/services/secure_storage_service.dart';
import 'package:easy_pay_app/features/auth/data/data_source/auth_remote_datasource.dart';
import 'package:easy_pay_app/features/auth/data/models/requests/reset_password_request.dart';
import 'package:easy_pay_app/features/auth/data/models/requests/send_otp_request.dart';
import 'package:easy_pay_app/features/auth/data/models/requests/sign_in_request.dart';
import 'package:easy_pay_app/features/auth/data/models/requests/sign_up_request.dart';
import 'package:easy_pay_app/features/auth/data/models/requests/verify_otp_request.dart';
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
  Future<UserEntity> signIn(SignInRequest request) async {
    final userModel = await remoteDataSource.signIn(request);
    if (userModel.accessToken != null && userModel.accessToken!.isNotEmpty) {
      await secureStorageService.saveAccessToken(userModel.accessToken!);
    }
    if (userModel.refreshToken != null && userModel.refreshToken!.isNotEmpty) {
      await secureStorageService.saveRefreshToken(userModel.refreshToken!);
    }
    return userModel;
  }

  @override
  Future<UserEntity> signUp(SignUpRequest request) async {
    final userModel = await remoteDataSource.signUp(request);
    if (userModel.accessToken != null && userModel.accessToken!.isNotEmpty) {
      await secureStorageService.saveAccessToken(userModel.accessToken!);
    }
    if (userModel.refreshToken != null && userModel.refreshToken!.isNotEmpty) {
      await secureStorageService.saveRefreshToken(userModel.refreshToken!);
    }
    return userModel;
  }

  @override
  Future<void> sendOtp(SendOtpRequest request) async {
    await remoteDataSource.sendOtp(request);
  }

  @override
  Future<void> verifyOtp(VerifyOtpRequest request) async {
    await remoteDataSource.verifyOtp(request);
  }

  @override
  Future<void> resetPassword(ResetPasswordRequest request) async {
    await remoteDataSource.resetPassword(request);
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
