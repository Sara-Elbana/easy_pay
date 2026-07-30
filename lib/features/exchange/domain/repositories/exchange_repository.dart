import '../../../../core/network/api_result.dart';
import '../../data/models/requests/convert_currency_request.dart';

abstract class ExchangeRepository {
  Future<ApiResult<Map<String, dynamic>>> convertCurrency(ConvertCurrencyRequest request);
}
