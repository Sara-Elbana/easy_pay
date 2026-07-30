import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/network/api_service.dart';
import '../models/requests/convert_currency_request.dart';

abstract class ExchangeRemoteDataSource {
  Future<ApiResult<Map<String, dynamic>>> convertCurrency(ConvertCurrencyRequest request);
}

class ExchangeRemoteDataSourceImpl implements ExchangeRemoteDataSource {
  final ApiService _apiService;

  ExchangeRemoteDataSourceImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<ApiResult<Map<String, dynamic>>> convertCurrency(ConvertCurrencyRequest request) async {
    try {
      final response = await _apiService.post(
        ApiConstants.convertCurrencyEndpoint,
        data: request.toJson(),
      );

      if (response.data != null && response.data is Map) {
        final double convertedAmount =
            (response.data['converted_amount'] as num).toDouble();
        final double reqAmount = (response.data['amount'] as num).toDouble();
        return ApiSuccess(data: {
          'rate': convertedAmount / reqAmount,
          'result': convertedAmount,
        });
      }
      return const ApiFailure(error: 'Failed to convert currency');
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
