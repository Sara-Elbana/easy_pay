import '../../domain/repositories/exchange_repository.dart';
import '../data_sources/exchange_remote_data_source.dart';

class ExchangeRepositoryImpl implements ExchangeRepository {
  final ExchangeRemoteDataSource remoteDataSource;

  ExchangeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Map<String, dynamic>> convertCurrency({
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
