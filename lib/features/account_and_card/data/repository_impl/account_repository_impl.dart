import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/account_and_card/data/datasources/account_remote_data_source.dart';
import 'package:easy_pay_app/features/account_and_card/data/models/account_model.dart';
import 'package:easy_pay_app/features/account_and_card/domain/entities/account_entity.dart';
import 'package:easy_pay_app/features/account_and_card/domain/entities/bank_card_entity.dart';
import 'package:easy_pay_app/features/account_and_card/domain/repository_interface/account_repository_interface.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountRemoteDataSource remoteDataSource;

  AccountRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ApiResult<List<AccountEntity>>> getAccounts() async {
    final result = await remoteDataSource.getAccounts();

    if (result is ApiSuccess<List<AccountModel>>) {
      final entities = result.data.map((model) => AccountEntity(
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

      return ApiSuccess(data: entities, message: result.message);
    }

    final failure = result as ApiFailure<List<AccountModel>>;
    return ApiFailure(error: failure.error, message: failure.message);
  }
}