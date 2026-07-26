import 'package:easy_pay_app/features/auth/domain/repository_interface/auth_repository.dart';

class VerifyOtpUseCase {
  final AuthRepository repository;

  VerifyOtpUseCase(this.repository);

  Future<void> call(String phoneNumber, String code) {
    return repository.verifyOtp(phoneNumber, code);
  }
}
