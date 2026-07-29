import 'package:equatable/equatable.dart';
import 'chart_data_entity.dart';
import 'report_transactions_entity.dart';

class TransactionReportEntity extends Equatable {
  final List<ChartDataEntity> chartData;
  final ReportTransactionsEntity reportTransactions;

  const TransactionReportEntity({
    required this.chartData,
    required this.reportTransactions,
  });

  @override
  List<Object?> get props => [chartData, reportTransactions];
}
