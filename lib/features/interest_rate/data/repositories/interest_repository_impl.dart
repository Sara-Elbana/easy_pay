import 'package:easy_pay_app/features/interest_rate/data/datasources/interest_remote_data_source.dart';
import 'package:easy_pay_app/features/interest_rate/domain/entities/interest_rate.dart';
import 'package:easy_pay_app/features/interest_rate/domain/repositories/interest_repository.dart';

class InterestRepositoryImpl implements InterestRepository {
  final InterestRemoteDataSource remoteDataSource;

  InterestRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<InterestRate>> getInterestRates() async {
    return await remoteDataSource.getInterestRates();
  }
}
