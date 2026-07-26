import 'package:easy_pay_app/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> signIn(String phoneNumber, String password);
  Future<UserEntity> signUp(String name, String phoneNumber, String password);
  Future<void> sendOtp(String phoneNumber);
  Future<void> verifyOtp(String phoneNumber, String code);
  Future<void> resetPassword(String phoneNumber, String code, String newPassword);
  Future<void> signOut();
}

class FakeAuthRepository implements AuthRepository {
  @override
  Future<UserEntity> signIn(String phoneNumber, String password) async {
    return UserEntity(
        id: '1', name: 'Sara', phoneNumber: phoneNumber, password: '123456');
  }

  @override
  Future<UserEntity> signUp(
    String name,
    String phoneNumber,
    String password,
  ) async {
    return UserEntity(
      id: '1',
      name: name,
      phoneNumber: phoneNumber,
      password: password,
    );
  }

  @override
  Future<void> sendOtp(String phoneNumber) async {}

  @override
  Future<void> verifyOtp(String phoneNumber, String code) async {}

  @override
  Future<void> resetPassword(String phoneNumber, String code, String newPassword) async {}

  @override
  Future<void> signOut() async {}
}
