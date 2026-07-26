import 'package:easy_pay_app/features/interest_rate/domain/entities/interest_rate.dart';

abstract class InterestRepository {
  Future<List<InterestRate>> getInterestRates();
}