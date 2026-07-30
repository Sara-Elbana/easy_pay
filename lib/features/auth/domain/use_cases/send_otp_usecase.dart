import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/auth/data/models/requests/send_otp_request.dart';
import 'package:easy_pay_app/features/auth/domain/repository_interface/auth_repository.dart';

class SendOtpUseCase {
  final AuthRepository repository;

  SendOtpUseCase(this.repository);

  Future<ApiResult<bool>> call(SendOtpRequest request) async {
    return await repository.sendOtp(request);
  }
}
