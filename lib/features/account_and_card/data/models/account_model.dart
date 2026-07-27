import 'package:easy_pay_app/features/account_and_card/data/models/bank_card_model.dart';

class AccountModel {
  final int id;
  final int userId;
  final String accountNumber;
  final String balance;
  final List<BankCardModel> bankCards;

  AccountModel({
    required this.id,
    required this.userId,
    required this.accountNumber,
    required this.balance,
    required this.bankCards,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    var cardsList = json['bank_cards'] as List? ?? [];
    List<BankCardModel> cards =
    cardsList.map((card) => BankCardModel.fromJson(card)).toList();

    return AccountModel(
      id: json['id'],
      userId: json['user_id'],
      accountNumber: json['account_number'],
      balance: json['balance'],
      bankCards: cards,
    );
  }

  static List<AccountModel> listFromJson(Map<String, dynamic> json) {
    var dataList = json['data'] ?? json['accounts'] ?? [];
    return (dataList as List)
        .map((accountJson) => AccountModel.fromJson(accountJson))
        .toList();
  }
}
