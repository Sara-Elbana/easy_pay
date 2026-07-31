import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/save_online/data/model/savings_account_model.dart';
import 'package:easy_pay_app/features/save_online/domain/repository_interface/management_repository_interface.dart';

class GetSavingsAccountsUseCase {
  final ManagementRepositoryInterface repository;

  GetSavingsAccountsUseCase(this.repository);

  Future<ApiResult<List<SavingsAccountModel>>> call() async {
    return await repository.getSavingsAccounts();
  }

}

