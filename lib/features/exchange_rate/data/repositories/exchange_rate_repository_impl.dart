import 'package:easy_pay_app/core/network/api_result.dart';
import '../../domain/entities/exchange_rate.dart';
import '../../domain/repositories/exchange_rate_repository.dart';
import '../data_source/exchange_rate_remote_datasource.dart';
import 'package:easy_pay_app/core/constants/app_assets.dart';

class ExchangeRateRepositoryImpl implements ExchangeRateRepository {
  final ExchangeRateRemoteDataSource remoteDataSource;

  ExchangeRateRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ApiResult<List<ExchangeRate>>> getLiveExchangeRates() async {
    final result = await remoteDataSource.fetchLiveExchangeRates();

    if (result is ApiSuccess<List<Map<String, dynamic>>>) {
      final entities = result.data.map((json) {
        final code = json['currency_code'] as String? ?? '';
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
          buy: double.tryParse(json['buy_rate'].toString()) ?? 0.0,
          sell: double.tryParse(json['sell_rate'].toString()) ?? 0.0,
          flagAsset: flagAsset,
        );
      }).toList();

      return ApiSuccess(data: entities, message: result.message);
    }

    final failure = result as ApiFailure<List<Map<String, dynamic>>>;
    return ApiFailure(error: failure.error, message: failure.message);
  }
}
