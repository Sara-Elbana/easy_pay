import 'package:dio/dio.dart';
import 'package:easy_pay_app/core/constants/api_constants.dart';
import 'package:easy_pay_app/core/network/api_service.dart';
import '../models/transaction_report_response_model.dart';

abstract class TransactionReportRemoteDataSource {
  Future<TransactionReportResponseModel> getMonthlyReport();
}

class TransactionReportRemoteDataSourceImpl
    implements TransactionReportRemoteDataSource {
  final ApiService apiService;

  TransactionReportRemoteDataSourceImpl({required this.apiService});

  @override
  Future<TransactionReportResponseModel> getMonthlyReport() async {
    try {
      final response = await apiService.get(ApiConstants.reportsMonthlyEndpoint);
      if (response.data != null && response.data is Map<String, dynamic>) {
        return TransactionReportResponseModel.fromJson(
            response.data as Map<String, dynamic>);
      }
      throw Exception('Invalid response format');
    } catch (e) {
      if (e is DioException) {
        throw Exception(
            e.response?.data['message'] ?? e.message ?? ApiConstants.unknownError);
      }
      rethrow;
    }
  }
}
