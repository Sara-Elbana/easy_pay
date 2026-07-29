import 'package:equatable/equatable.dart';

class ChartDataEntity extends Equatable {
  final String month;
  final double income;
  final double expense;

  const ChartDataEntity({
    required this.month,
    required this.income,
    required this.expense,
  });

  @override
  List<Object?> get props => [month, income, expense];
}
