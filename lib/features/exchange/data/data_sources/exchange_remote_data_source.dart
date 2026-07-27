import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_service.dart';

abstract class ExchangeRemoteDataSource {
  Future<Map<String, dynamic>> convertCurrency({
    required String from,
    required String to,
    required double amount,
  });
}

class ExchangeRemoteDataSourceImpl implements ExchangeRemoteDataSource {
  final ApiService _apiService;

  ExchangeRemoteDataSourceImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<Map<String, dynamic>> convertCurrency({
    required String from,
    required String to,
    required double amount,
  }) async {
    try {
      final response = await _apiService.post(
        ApiConstants.convertCurrencyEndpoint,
        data: {
          'from_currency': from,
          'to_currency': to,
          'amount': amount,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        final double convertedAmount =
            (response.data['converted_amount'] as num).toDouble();
        final double reqAmount = (response.data['amount'] as num).toDouble();
        return {
          'rate': convertedAmount / reqAmount,
          'result': convertedAmount,
        };
      }
      throw Exception('Failed to convert currency');
    } catch (e) {
      rethrow;
    }
  }
}
