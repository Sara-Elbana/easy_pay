import 'package:easy_pay_app/features/interest_rate/domain/entities/interest_rate.dart';
import 'package:easy_pay_app/features/interest_rate/domain/repositories/interest_repository.dart';

class GetInterestRatesUseCase {
  final InterestRepository repository;

  GetInterestRatesUseCase(this.repository);

  Future<List<InterestRate>> call() {
    return repository.getInterestRates();
  }
}
