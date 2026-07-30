import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/interest_rate/data/datasources/interest_remote_data_source.dart';
import 'package:easy_pay_app/features/interest_rate/data/models/interest_rate_model.dart';
import 'package:easy_pay_app/features/interest_rate/domain/entities/interest_rate.dart';
import 'package:easy_pay_app/features/interest_rate/domain/repositories/interest_repository.dart';

class InterestRepositoryImpl implements InterestRepository {
  final InterestRemoteDataSource remoteDataSource;

  InterestRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<ApiResult<List<InterestRate>>> getInterestRates() async {
    final result = await remoteDataSource.getInterestRates();

    if (result is ApiSuccess<List<InterestRateModel>>) {
      return ApiSuccess(
        data: result.data,
      );
    }

    final failure = result as ApiFailure<List<InterestRateModel>>;

    return ApiFailure(
      error: failure.error,
      message: failure.message,
    );
  }
}
