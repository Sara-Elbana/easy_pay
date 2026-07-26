import 'package:dartz/dartz.dart';
import 'package:easy_pay_app/core/errors/failures.dart';
import 'package:easy_pay_app/features/account_and_card/domain/entities/account_entity.dart';

abstract class AccountRepository {
  Future<Either<Failure, List<AccountEntity>>> getAccounts();
}
