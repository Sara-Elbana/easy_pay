import 'package:easy_pay_app/core/network/api_result.dart';
import '../../domain/entities/exchange_rate.dart';

abstract class ExchangeRateRepository {
  Future<ApiResult<List<ExchangeRate>>> getLiveExchangeRates();
}
