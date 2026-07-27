import 'package:easy_pay_app/features/account_and_card/data/models/bank_account_model.dart';
import 'package:easy_pay_app/features/account_and_card/domain/entities/card_entity.dart';

class CardModel extends CardEntity {
  const CardModel({
    required super.id,
    required super.cardHolderName,
    required super.cardType,
    required super.cardNumber,
    required super.maskedCardNumber,
    required super.expirationDate,
    required super.isActive,
    required super.bankAccount,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json['id'] ?? 0,
      cardHolderName: json['card_holder_name'] ?? '',
      cardType: json['card_type'] ?? '',
      cardNumber: json['card_number'] ?? '',
      maskedCardNumber: json['masked_card_number'] ?? '',
      expirationDate: json['expiration_date'] ?? '',
      isActive: json['is_active'] ?? true,
      bankAccount: json['bank_account'] != null
          ? BankAccountModel.fromJson(json['bank_account'])
          : const BankAccountModel(id: 0, accountNumber: '', balance: '0.00'),
    );
  }

  static List<CardModel> listFromJson(dynamic json) {
    var dataList = json is Map ? (json['data'] ?? json['cards'] ?? []) : json;
    return (dataList as List)
        .map((cardJson) => CardModel.fromJson(cardJson))
        .toList();
  }
}
