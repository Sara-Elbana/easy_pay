import 'package:dio/dio.dart';
import 'package:easy_pay_app/core/constants/api_constants.dart';
import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/core/network/api_service.dart';
import 'package:easy_pay_app/features/save_online/data/model/savings_account_model.dart';
import 'package:easy_pay_app/features/save_online/data/models/requests/create_saving_request.dart';

class SavingsRemoteDataSource {
  final ApiService apiService;
  SavingsRemoteDataSource(this.apiService);

  Future<ApiResult<List<SavingsAccountModel>>> getSavingsAccounts() async {
    try {
      final response = await apiService.get(ApiConstants.savingEndpoint);
      if (response.data == null || response.data['savings_accounts'] == null) {
        return const ApiFailure(error: 'Invalid response format');
      }
      final savingsList = SavingsAccountModel.fromJsonList(
        response.data['savings_accounts'] as List,
      );
      return ApiSuccess(data: savingsList);
    } on DioException catch (e) {
      return ApiFailure(error: _extractErrorMessage(e));
    } catch (_) {
      return const ApiFailure(error: ApiConstants.unknownError);
    }
  }

  Future<ApiResult<SavingsAccountModel>> createSaving(
    CreateSavingRequest request,
  ) async {
    try {
      final response = await apiService.post(
        ApiConstants.savingEndpoint,
        data: request.toJson(),
      );
      if (response.data == null || response.data['savings_account'] == null) {
        return const ApiFailure(error: 'Invalid response format');
      }
      final savingModel = SavingsAccountModel.fromJson(
        response.data['savings_account'] as Map<String, dynamic>,
      );
      return ApiSuccess(
        data: savingModel,
        message: response.data['message']?.toString(),
      );
    } on DioException catch (e) {
      return ApiFailure(error: _extractErrorMessage(e));
    } catch (_) {
      return const ApiFailure(error: ApiConstants.unknownError);
    }
  }

  String _extractErrorMessage(DioException e) {
    if (e.response?.data != null && e.response?.data is Map) {
      final data = e.response!.data as Map<String, dynamic>;
      if (data.containsKey('message') && data['message'] != null) {
        return data['message'].toString();
      }
      if (data.containsKey('error') && data['error'] != null) {
        return data['error'].toString();
      }
    }
    return e.message ?? ApiConstants.unknownError;
  }
}
