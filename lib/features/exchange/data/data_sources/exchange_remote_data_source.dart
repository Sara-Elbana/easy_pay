import 'package:dio/dio.dart';
import 'package:easy_pay_app/core/network/api_config.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/dio_client.dart';

abstract class ExchangeRemoteDataSource {
  Future<Map<String, dynamic>> convertCurrency({
    required String from,
    required String to,
    required double amount,
  });
}

class ExchangeRemoteDataSourceImpl implements ExchangeRemoteDataSource {
  final Dio _dio;

  ExchangeRemoteDataSourceImpl({Dio? dio})
      : _dio = dio ?? DioClient.createDioClient(baseUrl: ApiConstants.currencyTopBaseUrl);

  @override
  Future<Map<String, dynamic>> convertCurrency({
    required String from,
    required String to,
    required double amount,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstants.currencyTopConvertEndpoint,
        queryParameters: {
          'amount': amount,
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
          return response.data['data'] as Map<String, dynamic>;
        }
      }
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        message: 'Failed to convert currency',
      );
    } catch (e) {
      rethrow;
    }
  }
}
