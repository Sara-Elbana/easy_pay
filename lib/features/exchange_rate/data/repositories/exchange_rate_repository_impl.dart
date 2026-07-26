import '../../domain/entities/exchange_rate.dart';
import '../../domain/repositories/exchange_rate_repository.dart';
import '../data_source/exchange_rate_remote_datasource.dart';
import 'package:easy_pay_app/core/constants/app_assets.dart';

class ExchangeRateRepositoryImpl implements ExchangeRateRepository {
  final ExchangeRateRemoteDataSource remoteDataSource;

  ExchangeRateRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<ExchangeRate>> getLiveExchangeRates() async {
    final List<Map<String, dynamic>> rawData =
        await remoteDataSource.fetchLiveExchangeRates();

    return rawData.map((json) {
      final code = json['currency_code'] as String;
      String flagAsset = '';

      switch (code) {
        case 'EUR':
          flagAsset = AppAssets.flagFr;
          break;
        case 'GBP':
          flagAsset = AppAssets.flagGb;
          break;
        case 'EGP':
          flagAsset = AppAssets.flagEg;
          break;
        case 'SAR':
          flagAsset = AppAssets.flagSa;
          break;
        case 'AED':
          flagAsset = AppAssets.flagAe;
          break;
        default:
          flagAsset = '';
      }

      return ExchangeRate(
        id: json['id'].toString(),
        country: json['country_name'] ?? '',
        buy: double.parse(json['buy_rate'].toString()),
        sell: double.parse(json['sell_rate'].toString()),
        flagAsset: flagAsset,
      );
    }).toList();
  }
}
