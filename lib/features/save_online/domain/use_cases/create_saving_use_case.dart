import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/save_online/data/model/savings_account_model.dart';
import 'package:easy_pay_app/features/save_online/domain/repository_interface/management_repository_interface.dart';

class CreateSavingUseCase {
  final ManagementRepositoryInterface repository;

  CreateSavingUseCase(this.repository);

  Future<ApiResult<SavingsAccountModel>> call({
    required int bankAccountId,
    required double amount,
    required int termMonths,
  }) async {
    return await repository.createSaving(
      bankAccountId: bankAccountId,
      amount: amount,
      termMonths: termMonths,
    );
  }
}