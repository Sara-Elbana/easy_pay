import 'package:easy_pay_app/core/network/api_result.dart';
import '../repositories/withdraw_repository.dart';

class ExecuteWithdrawUseCase {
  final WithdrawRepository repository;

  ExecuteWithdrawUseCase(this.repository);

  Future<ApiResult<bool>> call({
    required String cardId,
    required String phoneNumber,
    required double amount,
  }) {
    return repository.executeWithdraw(
      cardId: cardId,
      phoneNumber: phoneNumber,
      amount: amount,
    );
  }
}
