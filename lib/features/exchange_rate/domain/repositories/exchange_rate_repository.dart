import '../../domain/entities/exchange_rate.dart';

abstract class ExchangeRateRepository {
  Future<List<ExchangeRate>> getLiveExchangeRates();
}
