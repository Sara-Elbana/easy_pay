import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/interest_rate/domain/entities/interest_rate.dart';
import 'package:easy_pay_app/features/interest_rate/domain/repositories/interest_repository.dart';

class GetInterestRatesUseCase {
  final InterestRepository repository;

  GetInterestRatesUseCase(this.repository);

  Future<ApiResult<List<InterestRate>>> call() async {
    return await repository.getInterestRates();
  }
}
