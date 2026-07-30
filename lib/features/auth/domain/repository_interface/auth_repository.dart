import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/auth/data/models/requests/reset_password_request.dart';
import 'package:easy_pay_app/features/auth/data/models/requests/send_otp_request.dart';
import 'package:easy_pay_app/features/auth/data/models/requests/sign_in_request.dart';
import 'package:easy_pay_app/features/auth/data/models/requests/sign_up_request.dart';
import 'package:easy_pay_app/features/auth/data/models/requests/verify_otp_request.dart';
import 'package:easy_pay_app/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<ApiResult<UserEntity>> signIn(SignInRequest request);
  Future<ApiResult<UserEntity>> signUp(SignUpRequest request);
  Future<ApiResult<bool>> sendOtp(SendOtpRequest request);
  Future<ApiResult<bool>> verifyOtp(VerifyOtpRequest request);
  Future<ApiResult<bool>> resetPassword(ResetPasswordRequest request);
  Future<ApiResult<bool>> signOut();
}

class FakeAuthRepository implements AuthRepository {
  @override
  Future<ApiResult<UserEntity>> signIn(SignInRequest request) async {
    return ApiSuccess(
      data: UserEntity(
        id: '1', name: 'Sara', phoneNumber: request.phoneNumber, password: '123456'),
    );
  }

  @override
  Future<ApiResult<UserEntity>> signUp(SignUpRequest request) async {
    return ApiSuccess(
      data: UserEntity(
        id: '1',
        name: request.name,
        phoneNumber: request.phoneNumber,
        password: request.password,
      ),
    );
  }

  @override
  Future<ApiResult<bool>> sendOtp(SendOtpRequest request) async => const ApiSuccess(data: true);

  @override
  Future<ApiResult<bool>> verifyOtp(VerifyOtpRequest request) async => const ApiSuccess(data: true);

  @override
  Future<ApiResult<bool>> resetPassword(ResetPasswordRequest request) async => const ApiSuccess(data: true);

  @override
  Future<ApiResult<bool>> signOut() async => const ApiSuccess(data: true);
}
