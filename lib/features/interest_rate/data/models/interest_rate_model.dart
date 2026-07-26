import 'package:easy_pay_app/features/interest_rate/domain/entities/interest_rate.dart';

class InterestRateModel extends InterestRate {
  const InterestRateModel({
    required super.kind,
    required super.deposit,
    required super.rate,
  });

  factory InterestRateModel.fromJson(Map<String, dynamic> json) {
    final rawRate = json['rate'];
    final rateStr = rawRate != null ? (rawRate.toString().endsWith('%') ? rawRate.toString() : '$rawRate%') : '';

    return InterestRateModel(
      kind: json['kind'] ?? json['name'] ?? json['type'] ?? '',
      deposit: json['deposit'] ?? json['term'] ?? json['duration'] ?? '',
      rate: rateStr,
    );
  }
}
