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
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      cardHolderName: json['card_holder_name']?.toString() ?? '',
      cardType: json['card_type']?.toString() ?? '',
      cardNumber: json['card_number']?.toString() ?? '',
      maskedCardNumber: json['masked_card_number']?.toString() ?? '',
      expirationDate: json['expiration_date']?.toString() ?? '',
      isActive: json['is_active'] == true || json['is_active'] == 1,
      bankAccount: json['bank_account'] != null
          ? BankAccountModel.fromJson(
              json['bank_account'] as Map<String, dynamic>)
          : const BankAccountModel(id: 0, accountNumber: '', balance: '0.00'),
    );
  }

  static List<CardModel> listFromJson(dynamic json) {
    if (json == null) return [];
    var dataList = json is Map ? (json['data'] ?? json['cards'] ?? []) : json;
    if (dataList is! List) return [];
    return dataList
        .map((cardJson) => CardModel.fromJson(cardJson as Map<String, dynamic>))
        .toList();
  }
}
