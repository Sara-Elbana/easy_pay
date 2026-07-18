import 'package:easy_pay_app/features/bottomNav/message/domain/entities/account_entity.dart';

class AccountModel extends AccountEntity {
  const AccountModel({
    required super.title,
    required super.accountNumber,
    required super.availableBalance,
    required super.branch,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      title: json['title'] ?? '',
      accountNumber: json['accountNumber'] ?? '',
      availableBalance: (json['availableBalance'] as num).toDouble(),
      branch: json['branch'] ?? '',
    );
  }
}
