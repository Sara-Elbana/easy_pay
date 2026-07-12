import 'package:easy_pay_app/features/auth/domain/entities/user_entity.dart';
import 'package:easy_pay_app/features/auth/domain/repository_interface/auth_repository.dart';

class SignInUseCase {
  final AuthRepository repository;

  SignInUseCase(this.repository);

  Future<UserEntity> call(String username, String password) {
    return repository.signIn(username, password);
  }
}
