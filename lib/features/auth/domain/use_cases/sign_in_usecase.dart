import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/auth/data/models/requests/sign_in_request.dart';
import 'package:easy_pay_app/features/auth/domain/entities/user_entity.dart';
import 'package:easy_pay_app/features/auth/domain/repository_interface/auth_repository.dart';

class SignInUseCase {
  final AuthRepository repository;

  SignInUseCase(this.repository);

  Future<ApiResult<UserEntity>> call(SignInRequest request) async {
    return await repository.signIn(request);
  }
}
