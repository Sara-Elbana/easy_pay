import '../../../../core/network/api_result.dart';
import '../../domain/repositories/exchange_repository.dart';
import '../data_sources/exchange_remote_data_source.dart';
import '../models/requests/convert_currency_request.dart';

class ExchangeRepositoryImpl implements ExchangeRepository {
  final ExchangeRemoteDataSource remoteDataSource;

  ExchangeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ApiResult<Map<String, dynamic>>> convertCurrency(ConvertCurrencyRequest request) async {
    return await remoteDataSource.convertCurrency(request);
  }
}
