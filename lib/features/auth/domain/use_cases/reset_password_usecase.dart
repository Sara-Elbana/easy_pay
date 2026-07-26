import 'package:easy_pay_app/features/auth/domain/repository_interface/auth_repository.dart';

class ResetPasswordUseCase {
  final AuthRepository repository;

  ResetPasswordUseCase(this.repository);

  Future<void> call(String phoneNumber, String code, String newPassword) {
    return repository.resetPassword(phoneNumber, code, newPassword);
  }
}
