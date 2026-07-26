import 'package:dartz/dartz.dart';
import 'package:easy_pay_app/core/errors/failures.dart';
import 'package:easy_pay_app/features/account_and_card/data/datasources/account_remote_data_source.dart';
import 'package:easy_pay_app/features/account_and_card/domain/entities/account_entity.dart';
import 'package:easy_pay_app/features/account_and_card/domain/entities/bank_card_entity.dart';
import 'package:easy_pay_app/features/account_and_card/domain/repository_interface/account_repository_interface.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountRemoteDataSource remoteDataSource;

  AccountRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<AccountEntity>>> getAccounts() async {
    try {
      final models = await remoteDataSource.getAccounts();
      final entities = models.map((model) => AccountEntity(
        id: model.id,
        accountNumber: model.accountNumber,
        balance: model.balance,
        bankCards: model.bankCards.map((card) => BankCardEntity(
          id: card.id,
          cardNumber: card.cardNumber,
          cardHolderName: card.cardHolderName,
          cardType: card.cardType,
          expirationDate: card.expirationDate,
          cvv: card.cvv,
        )).toList(),
      )).toList();

      return Right(entities);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}