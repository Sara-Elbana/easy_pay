import 'package:easy_pay_app/core/errors/exceptions.dart';
import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/save_online/data/data_source/savings_remote_data_source.dart';
import 'package:easy_pay_app/features/save_online/data/model/savings_account_model.dart';
import 'package:easy_pay_app/features/save_online/domain/repository_interface/management_repository_interface.dart';

class ManagementRepositoryImpl implements ManagementRepositoryInterface {
  final SavingsRemoteDataSource remoteDataSource;

  ManagementRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ApiResult<List<SavingsAccountModel>>> getSavingsAccounts() async {
    try {
      final apiResult = await remoteDataSource.getSavingsAccounts();

      if (apiResult is ApiSuccess<List<SavingsAccountModel>>) {
        return ApiSuccess(data: apiResult.data ?? [], message: apiResult.message);
      }

      final failure = apiResult as ApiFailure<List<SavingsAccountModel>>;
      return ApiFailure(error: failure.error, message: failure.message);

    } on ServerException catch (e) {
      return ApiFailure(error: e.message);
    } catch (e) {
      return ApiFailure(error: e.toString());
    }
  }
  @override
  Future<ApiResult<SavingsAccountModel>> createSaving({
    required int bankAccountId,
    required double amount,
    required int termMonths,
  }) async {
    try {
      final apiResult = await remoteDataSource.createSaving(
        bankAccountId: bankAccountId,
        amount: amount,
        termMonths: termMonths,
      );

      if (apiResult is ApiSuccess<SavingsAccountModel>) {
        return ApiSuccess(data: apiResult.data, message: apiResult.message);
      }

      final failure = apiResult as ApiFailure<SavingsAccountModel>;
      return ApiFailure(error: failure.error, message: failure.message);

    } on ServerException catch (e) {
      return ApiFailure(error: e.message);
    } catch (e) {
      return ApiFailure(error: e.toString());
    }
  }
}