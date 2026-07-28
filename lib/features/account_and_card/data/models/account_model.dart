import 'package:easy_pay_app/features/account_and_card/data/models/bank_card_model.dart';
import 'package:easy_pay_app/features/account_and_card/domain/entities/account_entity.dart';

class AccountModel extends AccountEntity {
  AccountModel({
    required super.id,
    required super.accountNumber,
    required super.balance,
    required super.bankCards,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    var cardsList = json['bank_cards'] as List? ?? [];
    List<BankCardModel> cards = cardsList
        .map((card) => BankCardModel.fromJson(card as Map<String, dynamic>))
        .toList();

    return AccountModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      accountNumber: json['account_number']?.toString() ?? '',
      balance: json['balance']?.toString() ?? '0.00',
      bankCards: cards,
    );
  }

  static List<AccountModel> listFromJson(dynamic json) {
    if (json == null) return [];
    var dataList = json is Map ? (json['data'] ?? json['accounts'] ?? []) : json;
    if (dataList is! List) return [];
    return dataList
        .map((accountJson) => AccountModel.fromJson(accountJson as Map<String, dynamic>))
        .toList();
  }
}
