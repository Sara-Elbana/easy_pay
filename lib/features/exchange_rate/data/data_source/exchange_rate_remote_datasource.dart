import 'package:dio/dio.dart';
import 'package:easy_pay_app/core/constants/api_constants.dart';
import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/core/network/api_service.dart';

abstract class ExchangeRateRemoteDataSource {
  Future<ApiResult<List<Map<String, dynamic>>>> fetchLiveExchangeRates();
}

class ExchangeRateRemoteDataSourceImpl implements ExchangeRateRemoteDataSource {
  final ApiService _apiService;

  ExchangeRateRemoteDataSourceImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<ApiResult<List<Map<String, dynamic>>>> fetchLiveExchangeRates() async {
    try {
      final response = await _apiService.get(ApiConstants.exchangeRatesEndpoint);
      if (response.data != null && response.data is List) {
        final list = List<Map<String, dynamic>>.from(response.data);
        return ApiSuccess(data: list);
      }
      return const ApiFailure(error: 'Failed to fetch exchange rates');
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
