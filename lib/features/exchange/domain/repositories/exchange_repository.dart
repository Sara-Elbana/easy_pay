import '../../../../core/network/api_result.dart';

abstract class ExchangeRepository {
  Future<ApiResult<Map<String, dynamic>>> convertCurrency({
    required String from,
    required String to,
    required double amount,
  });
}
