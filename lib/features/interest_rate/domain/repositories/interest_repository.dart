import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/interest_rate/domain/entities/interest_rate.dart';

abstract class InterestRepository {
  Future<ApiResult<List<InterestRate>>> getInterestRates();
}