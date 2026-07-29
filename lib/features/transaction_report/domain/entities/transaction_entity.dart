import 'package:equatable/equatable.dart';

class TransactionEntity extends Equatable {
  final int id;
  final String title;
  final String? category;
  final double amount;
  final String? status;
  final String? date;

  const TransactionEntity({
    required this.id,
    required this.title,
    this.category,
    required this.amount,
    this.status,
    this.date,
  });

  @override
  List<Object?> get props => [id, title, category, amount, status, date];
}
