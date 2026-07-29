import '../../domain/entities/transaction_entity.dart';

class TransactionModel {
  final int id;
  final String title;
  final String? category;
  final double amount;
  final String? status;
  final String? date;

  TransactionModel({
    required this.id,
    required this.title,
    this.category,
    required this.amount,
    this.status,
    this.date,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      category: json['category'] as String?,
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] as String?,
      date: json['date'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'category': category,
        'amount': amount,
        'status': status,
        'date': date,
      };

  TransactionEntity toEntity() => TransactionEntity(
        id: id,
        title: title,
        category: category,
        amount: amount,
        status: status,
        date: date,
      );
}
