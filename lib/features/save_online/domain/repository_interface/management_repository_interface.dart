import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/save_online/data/models/requests/create_saving_request.dart';
import 'package:easy_pay_app/features/save_online/domain/entity/savings_account_entity.dart';

abstract class ManagementRepositoryInterface {
  Future<ApiResult<List<SavingsAccountEntity>>> getSavingsAccounts();
  Future<ApiResult<SavingsAccountEntity>> createSaving(CreateSavingRequest request);
}
