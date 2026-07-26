import 'package:easy_pay_app/features/account_and_card/domain/entities/bank_account_entity.dart';

class CardEntity {
  final int id;
  final String cardHolderName;
  final String cardType;
  final String cardNumber;
  final String maskedCardNumber;
  final String expirationDate;
  final bool isActive;
  final BankAccountEntity bankAccount;

  const CardEntity({
    required this.id,
    required this.cardHolderName,
    required this.cardType,
    required this.cardNumber,
    required this.maskedCardNumber,
    required this.expirationDate,
    required this.isActive,
    required this.bankAccount,
  });
}