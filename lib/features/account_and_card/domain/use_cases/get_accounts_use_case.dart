import 'package:dartz/dartz.dart';
import 'package:easy_pay_app/core/errors/failures.dart';
import 'package:easy_pay_app/features/account_and_card/domain/entities/account_entity.dart';
import 'package:easy_pay_app/features/account_and_card/domain/repository_interface/account_repository_interface.dart';

class GetAccountsUseCase {
  final AccountRepository repository;

  GetAccountsUseCase(this.repository);

  Future<Either<Failure,List<AccountEntity>>> call() async {
    return await repository.getAccounts();
  }
}
