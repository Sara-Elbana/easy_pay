import 'package:dio/dio.dart';
import 'package:easy_pay_app/core/constants/api_constants.dart';
import 'package:easy_pay_app/core/network/api_config.dart';
import 'package:easy_pay_app/core/network/dio_client.dart';

abstract class ExchangeRateRemoteDataSource {
  Future<double> fetchLiveRate({required String from, required String to});
}

class ExchangeRateRemoteDataSourceImpl implements ExchangeRateRemoteDataSource {
  final Dio _dio;

  ExchangeRateRemoteDataSourceImpl({Dio? dio})
      : _dio = dio ??
            DioClient.createDioClient(baseUrl: ApiConstants.currencyTopBaseUrl);

  @override
  Future<double> fetchLiveRate(
      {required String from, required String to}) async {
    try {
      final response = await _dio.get(
        ApiConstants.currencyTopConvertEndpoint,
        queryParameters: {
          'amount': 1,
          'from': from,
          'to': to,
        },
        options: Options(
          headers: {
            'x-api-key': ApiConfig.currencyTopApiKey,
          },
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        final success = response.data['success'] as bool? ?? false;
        if (success && response.data['data'] != null) {
          final rate = response.data['data']['rate'];
          if (rate != null) {
            return (rate as num).toDouble();
          }
        }
      }
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        message: 'Failed to fetch rate from $from to $to',
      );
    } catch (e) {
      rethrow;
    }
  }
}
