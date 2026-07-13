import 'package:easy_pay_app/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> signIn(String phoneNumber, String password);
  Future<UserEntity> signUp(String name, String phoneNumber, String password);
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
}
