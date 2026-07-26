import 'package:easy_pay_app/features/account_and_card/domain/entities/bank_card_entity.dart';

class AccountEntity {
  final int id;
  final String accountNumber;
  final String balance;
  final List<BankCardEntity> bankCards;

  AccountEntity({
    required this.id,
    required this.accountNumber,
    required this.balance,
    required this.bankCards,
  });
}
