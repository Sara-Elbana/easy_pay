import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/save_online/data/data_source/savings_remote_data_source.dart';
import 'package:easy_pay_app/features/save_online/data/model/savings_account_model.dart';
import 'package:easy_pay_app/features/save_online/data/models/requests/create_saving_request.dart';
import 'package:easy_pay_app/features/save_online/domain/entity/savings_account_entity.dart';
import 'package:easy_pay_app/features/save_online/domain/repository_interface/management_repository_interface.dart';

class ManagementRepositoryImpl implements ManagementRepositoryInterface {
  final SavingsRemoteDataSource remoteDataSource;

  ManagementRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ApiResult<List<SavingsAccountEntity>>> getSavingsAccounts() async {
    final result = await remoteDataSource.getSavingsAccounts();

    if (result is ApiSuccess<List<SavingsAccountModel>>) {
      final entities = result.data.map((model) => model.toEntity()).toList();
      return ApiSuccess(data: entities, message: result.message);
    }

    final failure = result as ApiFailure<List<SavingsAccountModel>>;
    return ApiFailure(error: failure.error, message: failure.message);
  }

  @override
  Future<ApiResult<SavingsAccountEntity>> createSaving(
    CreateSavingRequest request,
  ) async {
    final result = await remoteDataSource.createSaving(request);

    if (result is ApiSuccess<SavingsAccountModel>) {
      return ApiSuccess(data: result.data.toEntity(), message: result.message);
    }

    final failure = result as ApiFailure<SavingsAccountModel>;
    return ApiFailure(error: failure.error, message: failure.message);
  }
}