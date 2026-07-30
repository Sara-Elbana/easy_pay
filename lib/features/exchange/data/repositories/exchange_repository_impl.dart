import '../../../../core/network/api_result.dart';
import '../../domain/repositories/exchange_repository.dart';
import '../data_sources/exchange_remote_data_source.dart';

class ExchangeRepositoryImpl implements ExchangeRepository {
  final ExchangeRemoteDataSource remoteDataSource;

  ExchangeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ApiResult<Map<String, dynamic>>> convertCurrency({
    required String from,
    required String to,
    required double amount,
  }) async {
    return await remoteDataSource.convertCurrency(
      from: from,
      to: to,
      amount: amount,
    );
  }
}
