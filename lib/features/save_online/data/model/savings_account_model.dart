import 'package:easy_pay_app/features/save_online/domain/entity/savings_account_entity.dart';

class SavingsAccountModel extends SavingsAccountEntity {
  SavingsAccountModel({
    required super.id,
    required super.userId,
    required super.bankAccountId,
    required super.accountNumber,
    required super.amount,
    required super.termMonths,
    required super.interestRate,
    required super.startDate,
    required super.endDate,
    required super.status,
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
    return jsonList.map((item) => SavingsAccountModel.fromJson(item)).toList();
  }
  Map<String, dynamic> toJson() {
    return {
      "bank_account_id": bankAccountId,
      "amount": amount,
      "term_months": termMonths,
    };
  }
}
