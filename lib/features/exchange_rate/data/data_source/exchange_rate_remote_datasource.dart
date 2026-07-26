import 'package:dio/dio.dart';
import 'package:easy_pay_app/core/constants/api_constants.dart';
import 'package:easy_pay_app/core/network/dio_client.dart';

abstract class ExchangeRateRemoteDataSource {
  Future<List<Map<String, dynamic>>> fetchLiveExchangeRates();
}

class ExchangeRateRemoteDataSourceImpl implements ExchangeRateRemoteDataSource {
  final Dio _dio;

  ExchangeRateRemoteDataSourceImpl({Dio? dio})
      : _dio = dio ?? DioClient.createDioClient();

  @override
  Future<List<Map<String, dynamic>>> fetchLiveExchangeRates() async {
    try {
      final response = await _dio.get(ApiConstants.exchangeRatesEndpoint);
      if (response.statusCode == 200 && response.data != null) {
        return List<Map<String, dynamic>>.from(response.data);
      }
      throw Exception('Failed to fetch exchange rates');
    } catch (e) {
      rethrow;
    }
  }
}
