import 'package:easy_pay_app/core/network/api_result.dart';

abstract class WithdrawRepository {
  Future<ApiResult<bool>> executeWithdraw({
    required String cardId,
    required String phoneNumber,
    required double amount,
  });
}
