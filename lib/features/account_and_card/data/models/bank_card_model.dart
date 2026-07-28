import 'package:easy_pay_app/features/account_and_card/domain/entities/bank_card_entity.dart';

class BankCardModel extends BankCardEntity {
  final int bankAccountId;
  final int isActive;

  BankCardModel({
    required super.id,
    required this.bankAccountId,
    required super.cardNumber,
    required super.cardHolderName,
    required super.cardType,
    required super.expirationDate,
    required super.cvv,
    required this.isActive,
  });

  factory BankCardModel.fromJson(Map<String, dynamic> json) {
    return BankCardModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      bankAccountId: json['bank_account_id'] is int
          ? json['bank_account_id']
          : int.tryParse(json['bank_account_id']?.toString() ?? '0') ?? 0,
      cardNumber: json['card_number']?.toString() ?? '',
      cardHolderName: json['card_holder_name']?.toString() ?? '',
      cardType: json['card_type']?.toString() ?? '',
      expirationDate: json['expiration_date']?.toString() ?? '',
      cvv: json['cvv']?.toString() ?? '',
      isActive: json['is_active'] is int
          ? json['is_active']
          : (json['is_active'] == true ? 1 : 0),
    );
  }
}