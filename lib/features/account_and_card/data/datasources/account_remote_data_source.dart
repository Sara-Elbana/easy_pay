import 'package:dio/dio.dart';
import 'package:easy_pay_app/core/constants/api_constants.dart';
import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/core/network/api_service.dart';
import 'package:easy_pay_app/features/account_and_card/data/models/account_model.dart';

class AccountRemoteDataSource {
  final ApiService apiService;
  AccountRemoteDataSource(this.apiService);

  Future<ApiResult<List<AccountModel>>> getAccounts() async {
    try {
      final response = await apiService.get(ApiConstants.accountsEndpoint);
      if (response.data == null) {
        return const ApiFailure(error: 'Invalid response format');
      }
      final models = AccountModel.listFromJson(response.data);
      return ApiSuccess(data: models);
    } on DioException catch (e) {
      return ApiFailure(
        error: e.response?.data['message'] ??
            e.message ??
            ApiConstants.unknownError,
      );
    } catch (_) {
      return const ApiFailure(error: ApiConstants.unknownError);
    }
  }
}
