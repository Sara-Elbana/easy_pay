import '../../domain/entities/exchange_rate.dart';
import '../../domain/repositories/exchange_rate_repository.dart';
import '../data_source/exchange_rate_remote_datasource.dart';
import '../models/exchange_rate_config.dart';

class ExchangeRateRepositoryImpl implements ExchangeRateRepository {
  final ExchangeRateRemoteDataSource remoteDataSource;

  ExchangeRateRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<ExchangeRate>> getLiveExchangeRates() async {
    final List<Future<ExchangeRate>> futures =
        supportedCountries.map((config) async {
      final liveRate = await remoteDataSource.fetchLiveRate(
        from: 'USD',
        to: config.code,
      );

      final buy = double.parse((liveRate * 0.985).toStringAsFixed(3));
      final sell = double.parse((liveRate * 1.015).toStringAsFixed(3));

      return ExchangeRate(
        id: config.id,
        country: config.country,
        buy: buy,
        sell: sell,
        flagAsset: config.flagAsset,
      );
    }).toList();

    return await Future.wait(futures);
  }
}
