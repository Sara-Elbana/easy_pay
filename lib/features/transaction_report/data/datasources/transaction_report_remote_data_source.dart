import 'package:dio/dio.dart';
import 'package:easy_pay_app/core/constants/api_constants.dart';
import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/core/network/api_service.dart';

import '../models/transaction_report_response_model.dart';

abstract class TransactionReportRemoteDataSource {
  Future<ApiResult<TransactionReportResponseModel>> getMonthlyReport();
}

class TransactionReportRemoteDataSourceImpl
    implements TransactionReportRemoteDataSource {
  final ApiService apiService;

  TransactionReportRemoteDataSourceImpl({
    required this.apiService,
  });

  @override
  Future<ApiResult<TransactionReportResponseModel>> getMonthlyReport() async {
    try {
      final response = await apiService.get(
        ApiConstants.reportsMonthlyEndpoint,
      );

      if (response.data == null || response.data is! Map<String, dynamic>) {
        return const ApiFailure(
          error: 'Invalid response format',
        );
      }

      return ApiSuccess(
        data: TransactionReportResponseModel.fromJson(
          response.data as Map<String, dynamic>,
        ),
      );
    } on DioException catch (e) {
      return ApiFailure(
        error: e.response?.data['message'] ??
            e.message ??
            ApiConstants.unknownError,
      );
    } catch (_) {
      return const ApiFailure(
        error: ApiConstants.unknownError,
      );
    }
  }
}
