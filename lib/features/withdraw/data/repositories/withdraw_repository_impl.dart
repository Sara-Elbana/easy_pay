import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/withdraw/data/models/requests/withdraw_request.dart';
import '../../domain/repositories/withdraw_repository.dart';

class WithdrawRepositoryImpl implements WithdrawRepository {
  @override
  Future<ApiResult<bool>> executeWithdraw(WithdrawRequest request) async {
    // Simulate server API network call delay
    await Future.delayed(const Duration(seconds: 1));
    return const ApiSuccess(data: true);
  }
}
