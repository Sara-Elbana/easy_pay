import '../../domain/entities/chart_data_entity.dart';

class ChartDataModel {
  final String month;
  final double income;
  final double expense;

  ChartDataModel({
    required this.month,
    required this.income,
    required this.expense,
  });

  factory ChartDataModel.fromJson(Map<String, dynamic> json) {
    return ChartDataModel(
      month: json['month'] as String? ?? '',
      income: (json['income'] as num?)?.toDouble() ?? 0.0,
      expense: (json['expense'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
        'month': month,
        'income': income,
        'expense': expense,
      };

  ChartDataEntity toEntity() => ChartDataEntity(
        month: month,
        income: income,
        expense: expense,
      );
}
