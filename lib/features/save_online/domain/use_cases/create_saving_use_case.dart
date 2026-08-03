import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/save_online/data/models/requests/create_saving_request.dart';
import 'package:easy_pay_app/features/save_online/domain/entity/savings_account_entity.dart';
import 'package:easy_pay_app/features/save_online/domain/repository_interface/management_repository_interface.dart';

class CreateSavingUseCase {
  final ManagementRepositoryInterface repository;

  CreateSavingUseCase(this.repository);

  Future<ApiResult<SavingsAccountEntity>> call(CreateSavingRequest request) async {
    return await repository.createSaving(request);
  }
}