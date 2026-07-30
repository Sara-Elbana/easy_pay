import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/withdraw/data/models/requests/withdraw_request.dart';
import '../repositories/withdraw_repository.dart';

class ExecuteWithdrawUseCase {
  final WithdrawRepository repository;

  ExecuteWithdrawUseCase(this.repository);

  Future<ApiResult<bool>> call(WithdrawRequest request) {
    return repository.executeWithdraw(request);
  }
}
