import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/auth/data/models/requests/reset_password_request.dart';
import 'package:easy_pay_app/features/auth/domain/repository_interface/auth_repository.dart';

class ResetPasswordUseCase {
  final AuthRepository repository;

  ResetPasswordUseCase(this.repository);

  Future<ApiResult<bool>> call(ResetPasswordRequest request) async {
    return await repository.resetPassword(request);
  }
}
