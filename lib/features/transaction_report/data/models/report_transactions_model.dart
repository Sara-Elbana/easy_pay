import '../../domain/entities/report_transactions_entity.dart';
import 'transaction_model.dart';

class ReportTransactionsModel {
  final List<TransactionModel> today;
  final List<TransactionModel> yesterday;

  ReportTransactionsModel({
    required this.today,
    required this.yesterday,
  });

  factory ReportTransactionsModel.fromJson(Map<String, dynamic> json) {
    return ReportTransactionsModel(
      today: (json['today'] as List<dynamic>?)
              ?.map((e) => TransactionModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      yesterday: (json['yesterday'] as List<dynamic>?)
              ?.map((e) => TransactionModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        'today': today.map((e) => e.toJson()).toList(),
        'yesterday': yesterday.map((e) => e.toJson()).toList(),
      };

  ReportTransactionsEntity toEntity() => ReportTransactionsEntity(
        today: today.map((e) => e.toEntity()).toList(),
        yesterday: yesterday.map((e) => e.toEntity()).toList(),
      );
}
