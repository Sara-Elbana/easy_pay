import 'package:easy_pay_app/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> signIn(String username, String password);
  Future<UserEntity> signUp(String name, String username, String password);
}
class FakeAuthRepository implements AuthRepository {
  @override
  Future<UserEntity> signIn(String username, String password) async {
    return UserEntity(
      id: '1',
      name: 'Sara',
      username: username,
      password: '123456'
    );
  }

  @override
  Future<UserEntity> signUp(
      String name,
      String username,
      String password,
      ) async {
    return UserEntity(
      id: '1',
      name: name,
      username: username,
      password: password,
    );
  }
}