import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/account_and_card/domain/entities/account_entity.dart';

abstract class AccountRepository {
  Future<ApiResult<List<AccountEntity>>> getAccounts();
}
