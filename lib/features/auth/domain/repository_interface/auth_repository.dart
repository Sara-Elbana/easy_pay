import 'package:easy_pay_app/features/auth/data/models/requests/reset_password_request.dart';
import 'package:easy_pay_app/features/auth/data/models/requests/send_otp_request.dart';
import 'package:easy_pay_app/features/auth/data/models/requests/sign_in_request.dart';
import 'package:easy_pay_app/features/auth/data/models/requests/sign_up_request.dart';
import 'package:easy_pay_app/features/auth/data/models/requests/verify_otp_request.dart';
import 'package:easy_pay_app/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> signIn(SignInRequest request);
  Future<UserEntity> signUp(SignUpRequest request);
  Future<void> sendOtp(SendOtpRequest request);
  Future<void> verifyOtp(VerifyOtpRequest request);
  Future<void> resetPassword(ResetPasswordRequest request);
  Future<void> signOut();
}

class FakeAuthRepository implements AuthRepository {
  @override
  Future<UserEntity> signIn(SignInRequest request) async {
    return UserEntity(
        id: '1', name: 'Sara', phoneNumber: request.phoneNumber, password: '123456');
  }

  @override
  Future<UserEntity> signUp(SignUpRequest request) async {
    return UserEntity(
      id: '1',
      name: request.name,
      phoneNumber: request.phoneNumber,
      password: request.password,
    );
  }

  @override
  Future<void> sendOtp(SendOtpRequest request) async {}

  @override
  Future<void> verifyOtp(VerifyOtpRequest request) async {}

  @override
  Future<void> resetPassword(ResetPasswordRequest request) async {}

  @override
  Future<void> signOut() async {}
}
