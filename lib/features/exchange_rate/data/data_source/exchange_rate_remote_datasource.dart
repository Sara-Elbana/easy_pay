import 'package:easy_pay_app/core/constants/api_constants.dart';
import 'package:easy_pay_app/core/network/api_service.dart';

abstract class ExchangeRateRemoteDataSource {
  Future<List<Map<String, dynamic>>> fetchLiveExchangeRates();
}

class ExchangeRateRemoteDataSourceImpl implements ExchangeRateRemoteDataSource {
  final ApiService _apiService;

  ExchangeRateRemoteDataSourceImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<List<Map<String, dynamic>>> fetchLiveExchangeRates() async {
    try {
      final response = await _apiService.get(ApiConstants.exchangeRatesEndpoint);
      if (response.statusCode == 200 && response.data != null) {
        return List<Map<String, dynamic>>.from(response.data);
      }
      throw Exception('Failed to fetch exchange rates');
    } catch (e) {
      rethrow;
    }
  }
}
