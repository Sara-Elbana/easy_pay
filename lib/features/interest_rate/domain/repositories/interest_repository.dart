
import 'package:easy_pay_app/features/interest_rate/domain/entities/interest_rate.dart';

class InterestRemoteDataSource {
  Future<List<InterestRate>> getInterestRates() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      InterestRate(kind: "Individual customers", deposit: "1m", rate: "4.50%"),
      InterestRate(kind: "Corporate customers", deposit: "2m", rate: "5.50%"),
      InterestRate(kind: "Individual customers", deposit: "1m", rate: "4.50%"),
      InterestRate(kind: "Corporate customers", deposit: "6m", rate: "2.50%"),
      InterestRate(kind: "Individual customers", deposit: "1m", rate: "4.50%"),
      InterestRate(kind: "Corporate customers", deposit: "8m", rate: "6.50%"),
      InterestRate(kind: "Corporate customers", deposit: "6m", rate: "2.50%"),
      InterestRate(kind: "Individual customers", deposit: "1m", rate: "4.50%"),
      InterestRate(kind: "Corporate customers", deposit: "8m", rate: "6.50%"),
      InterestRate(kind: "Corporate customers", deposit: "6m", rate: "2.50%"),
      InterestRate(kind: "Individual customers", deposit: "1m", rate: "4.50%"),
      InterestRate(kind: "Corporate customers", deposit: "8m", rate: "6.50%"),
      InterestRate(kind: "Corporate customers", deposit: "6m", rate: "2.50%"),
      InterestRate(kind: "Individual customers", deposit: "1m", rate: "4.50%"),
    ];
  }
}