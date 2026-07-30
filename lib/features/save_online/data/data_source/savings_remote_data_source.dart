import 'package:easy_pay_app/core/core.dart';
import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/save_online/data/model/savings_account_model.dart';

class SavingsRemoteDataSource {
  final ApiService apiService;
  SavingsRemoteDataSource(this.apiService);

  Future<ApiResult<List<SavingsAccountModel>>> getSavingsAccounts() async {
    try {
      final response = await apiService.get(ApiConstants.savingEndpoint);
      final savingsList =
          SavingsAccountModel.fromJsonList(response.data['savings_accounts']);
      return ApiSuccess(data: savingsList);
    } catch (e) {
      return ApiFailure(error: e.toString());
    }
  }

  Future<ApiResult<SavingsAccountModel>> createSaving({
    required int bankAccountId,
    required double amount,
    required int termMonths,
  }) async {
    try {
      final response = await apiService.post(
        ApiConstants.savingEndpoint,
        data: {
          "bank_account_id": bankAccountId,
          "amount": amount,
          "term_months": termMonths,
        },
      );

      final savingModel =
      SavingsAccountModel.fromJson(response.data['savings_account']);

      return ApiSuccess(
        data: savingModel,
        message: response.data['message'],
      );
    } catch (e) {
      return ApiFailure(error: e.toString());
    }
  }
}
