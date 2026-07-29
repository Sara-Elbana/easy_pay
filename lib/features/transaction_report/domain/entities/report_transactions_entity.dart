import 'package:equatable/equatable.dart';
import 'transaction_entity.dart';

class ReportTransactionsEntity extends Equatable {
  final List<TransactionEntity> today;
  final List<TransactionEntity> yesterday;

  const ReportTransactionsEntity({
    required this.today,
    required this.yesterday,
  });

  @override
  List<Object?> get props => [today, yesterday];
}
