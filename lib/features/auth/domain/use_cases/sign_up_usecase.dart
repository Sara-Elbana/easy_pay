import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/auth/data/models/requests/sign_up_request.dart';
import 'package:easy_pay_app/features/auth/domain/entities/user_entity.dart';
import 'package:easy_pay_app/features/auth/domain/repository_interface/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  Future<ApiResult<UserEntity>> call(SignUpRequest request) async {
    return await repository.signUp(request);
  }
}
