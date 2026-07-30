
import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/save_online/data/model/savings_account_model.dart';

abstract class ManagementRepositoryInterface {
  Future<ApiResult<List<SavingsAccountModel>>> getSavingsAccounts();
  Future<ApiResult<SavingsAccountModel>> createSaving({
    required int bankAccountId,
    required double amount,
    required int termMonths,
  });
}
