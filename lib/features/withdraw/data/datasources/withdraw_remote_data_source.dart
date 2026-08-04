import 'package:dio/dio.dart';
import 'package:easy_pay_app/core/constants/api_constants.dart';
import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/core/network/api_service.dart';
import 'package:easy_pay_app/features/withdraw/data/models/requests/withdraw_request.dart';

abstract class WithdrawRemoteDataSource {
  Future<ApiResult<bool>> executeWithdraw(WithdrawRequest request);
}

class WithdrawRemoteDataSourceImpl implements WithdrawRemoteDataSource {
  final ApiService apiService;

  WithdrawRemoteDataSourceImpl({required this.apiService});

  @override
  Future<ApiResult<bool>> executeWithdraw(WithdrawRequest request) async {
    try {
      final response = await apiService.post(
        ApiConstants.withdrawEndpoint,
        data: request.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return const ApiSuccess(data: true);
      }
      return const ApiFailure(error: 'Failed to process withdrawal');
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
