import 'package:easy_pay_app/features/save_online/domain/entity/savings_account_entity.dart';

class SavingsAccountModel {
  final int id;
  final int userId;
  final int bankAccountId;
  final String accountNumber;
  final String amount;
  final int termMonths;
  final String interestRate;
  final String startDate;
  final String endDate;
  final String status;

  const SavingsAccountModel({
    required this.id,
    required this.userId,
    required this.bankAccountId,
    required this.accountNumber,
    required this.amount,
    required this.termMonths,
    required this.interestRate,
    required this.startDate,
    required this.endDate,
    required this.status,
  });

  factory SavingsAccountModel.fromJson(Map<String, dynamic> json) {
    return SavingsAccountModel(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      bankAccountId: json['bank_account_id'] ?? 0,
      accountNumber: json['account_number'] ?? '',
      amount: json['amount']?.toString() ?? '0.0',
      termMonths: json['term_months'] ?? 0,
      interestRate: json['interest_rate'] ?? '0.00',
      startDate: json['start_date'] ?? '',
      endDate: json['end_date'] ?? '',
      status: json['status'] ?? '',
    );
  }

  static List<SavingsAccountModel> fromJsonList(List jsonList) {
    return jsonList
        .map((item) =>
            SavingsAccountModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      "bank_account_id": bankAccountId,
      "amount": amount,
      "term_months": termMonths,
    };
  }

  SavingsAccountEntity toEntity() {
    return SavingsAccountEntity(
      id: id,
      userId: userId,
      bankAccountId: bankAccountId,
      accountNumber: accountNumber,
      amount: amount,
      termMonths: termMonths,
      interestRate: interestRate,
      startDate: startDate,
      endDate: endDate,
      status: status,
    );
  }
}
