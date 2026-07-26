import 'package:easy_pay_app/features/auth/domain/repository_interface/auth_repository.dart';

class SendOtpUseCase {
  final AuthRepository repository;

  SendOtpUseCase(this.repository);

  Future<void> call(String phoneNumber) {
    return repository.sendOtp(phoneNumber);
  }
}
