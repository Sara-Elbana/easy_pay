import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/core/services/secure_storage_service.dart';
import 'package:easy_pay_app/features/auth/data/data_source/auth_remote_datasource.dart';
import 'package:easy_pay_app/features/auth/data/models/requests/reset_password_request.dart';
import 'package:easy_pay_app/features/auth/data/models/requests/send_otp_request.dart';
import 'package:easy_pay_app/features/auth/data/models/requests/sign_in_request.dart';
import 'package:easy_pay_app/features/auth/data/models/requests/sign_up_request.dart';
import 'package:easy_pay_app/features/auth/data/models/requests/verify_otp_request.dart';
import 'package:easy_pay_app/features/auth/data/models/user_model.dart';
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
  Future<ApiResult<UserEntity>> signIn(SignInRequest request) async {
    final result = await remoteDataSource.signIn(request);
    if (result is ApiSuccess<UserModel>) {
      final userModel = result.data;
      if (userModel.accessToken != null && userModel.accessToken!.isNotEmpty) {
        await secureStorageService.saveAccessToken(userModel.accessToken!);
      }
      if (userModel.refreshToken != null && userModel.refreshToken!.isNotEmpty) {
        await secureStorageService.saveRefreshToken(userModel.refreshToken!);
      }
      return ApiSuccess(data: userModel, message: result.message);
    }
    final failure = result as ApiFailure<UserModel>;
    return ApiFailure(error: failure.error, message: failure.message);
  }

  @override
  Future<ApiResult<UserEntity>> signUp(SignUpRequest request) async {
    final result = await remoteDataSource.signUp(request);
    if (result is ApiSuccess<UserModel>) {
      final userModel = result.data;
      if (userModel.accessToken != null && userModel.accessToken!.isNotEmpty) {
        await secureStorageService.saveAccessToken(userModel.accessToken!);
      }
      if (userModel.refreshToken != null && userModel.refreshToken!.isNotEmpty) {
        await secureStorageService.saveRefreshToken(userModel.refreshToken!);
      }
      return ApiSuccess(data: userModel, message: result.message);
    }
    final failure = result as ApiFailure<UserModel>;
    return ApiFailure(error: failure.error, message: failure.message);
  }

  @override
  Future<ApiResult<bool>> sendOtp(SendOtpRequest request) async {
    return await remoteDataSource.sendOtp(request);
  }

  @override
  Future<ApiResult<bool>> verifyOtp(VerifyOtpRequest request) async {
    return await remoteDataSource.verifyOtp(request);
  }

  @override
  Future<ApiResult<bool>> resetPassword(ResetPasswordRequest request) async {
    return await remoteDataSource.resetPassword(request);
  }

  @override
  Future<ApiResult<bool>> signOut() async {
    final result = await remoteDataSource.signOut();
    await secureStorageService.clearSensitiveData();
    return result;
  }
}
