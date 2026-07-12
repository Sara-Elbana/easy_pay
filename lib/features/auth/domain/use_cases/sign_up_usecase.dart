import 'package:easy_pay_app/features/auth/domain/entities/user_entity.dart';
import 'package:easy_pay_app/features/auth/domain/repository_interface/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  Future<UserEntity> call(String name, String username, String password) {
    return repository.signUp(name, username, password);
  }
}
