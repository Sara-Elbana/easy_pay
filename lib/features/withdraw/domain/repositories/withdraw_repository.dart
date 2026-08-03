import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/withdraw/data/models/requests/withdraw_request.dart';

abstract class WithdrawRepository {
  Future<ApiResult<bool>> executeWithdraw(WithdrawRequest request);
}
