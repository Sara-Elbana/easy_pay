import '../../domain/entities/transaction_report_entity.dart';
import 'chart_data_model.dart';
import 'report_transactions_model.dart';

class TransactionReportResponseModel {
  final List<ChartDataModel> chartData;
  final ReportTransactionsModel reportTransactions;

  TransactionReportResponseModel({
    required this.chartData,
    required this.reportTransactions,
  });

  factory TransactionReportResponseModel.fromJson(Map<String, dynamic> json) {
    return TransactionReportResponseModel(
      chartData: (json['chart_data'] as List<dynamic>?)
              ?.map((e) => ChartDataModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      reportTransactions: ReportTransactionsModel.fromJson(
        (json['report_transactions'] as Map<String, dynamic>?) ?? {},
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'chart_data': chartData.map((e) => e.toJson()).toList(),
        'report_transactions': reportTransactions.toJson(),
      };

  TransactionReportEntity toEntity() => TransactionReportEntity(
        chartData: chartData.map((e) => e.toEntity()).toList(),
        reportTransactions: reportTransactions.toEntity(),
      );
}
