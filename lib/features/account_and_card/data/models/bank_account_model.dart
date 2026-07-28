import 'package:easy_pay_app/features/account_and_card/domain/entities/bank_account_entity.dart';

class BankAccountModel extends BankAccountEntity {
  const BankAccountModel({
    required super.id,
    required super.accountNumber,
    required super.balance,
  });

  factory BankAccountModel.fromJson(Map<String, dynamic> json) {
    return BankAccountModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      accountNumber: json['account_number']?.toString() ?? '',
      balance: json['balance']?.toString() ?? '0.00',
    );
  }
}