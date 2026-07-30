import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/auth/domain/repository_interface/auth_repository.dart';

class SignOutUseCase {
  final AuthRepository repository;

  SignOutUseCase(this.repository);

  Future<ApiResult<bool>> call() async {
    return await repository.signOut();
  }
}
