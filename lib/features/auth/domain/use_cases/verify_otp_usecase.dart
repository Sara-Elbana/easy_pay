import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/auth/data/models/requests/verify_otp_request.dart';
import 'package:easy_pay_app/features/auth/domain/repository_interface/auth_repository.dart';

class VerifyOtpUseCase {
  final AuthRepository repository;

  VerifyOtpUseCase(this.repository);

  Future<ApiResult<bool>> call(VerifyOtpRequest request) async {
    return await repository.verifyOtp(request);
  }
}
