import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/theme/app_text_styles.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:easy_pay_app/features/transaction_report/domain/entities/chart_data_entity.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TransactionChartCard extends StatelessWidget {
  final List<ChartDataEntity> chartData;

  const TransactionChartCard({
    super.key,
    required this.chartData,
  });

  @override
  Widget build(BuildContext context) {
    double totalIncome = 0;
    double totalExpense = 0;
    double maxVal = 0;

    for (final item in chartData) {
      totalIncome += item.income;
      totalExpense += item.expense;
      if (item.income > maxVal) maxVal = item.income;
      if (item.expense > maxVal) maxVal = item.expense;
      if (item.income + item.expense > maxVal) {
        maxVal = item.income + item.expense;
      }
    }

    final double balance = totalIncome - totalExpense;
    final double maxY = maxVal <= 0 ? 100.0 : (maxVal * 1.2);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(context.scaleWidth(20)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.scaleWidth(20)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 20,
            spreadRadius: 0,
            offset: Offset(0, 5),
          ),
        ],
        border: Border.all(
          color: AppColors.softGray,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Balance',
            style: AppTextStyles.bodyMediumGray.copyWith(
              color: AppColors.gray500,
              fontSize: context.scaleWidth(14),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: context.scaleHeight(4)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                balance >= 0
                    ? balance.toStringAsFixed(0)
                    : '-${balance.abs().toStringAsFixed(0)}',
                style: TextStyle(
                  fontSize: context.scaleWidth(32),
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(width: context.scaleWidth(6)),
              Text(
                'USD',
                style: TextStyle(
                  fontSize: context.scaleWidth(14),
                  fontWeight: FontWeight.w500,
                  color: AppColors.lightGray,
                ),
              ),
            ],
          ),
          SizedBox(height: context.scaleHeight(24)),

          // FL Chart Section
          SizedBox(
            height: context.scaleHeight(180),
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: maxY,
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(
                  show: true,
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 28,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index < 0 || index >= chartData.length) {
                          return const SizedBox.shrink();
                        }
                        final data = chartData[index];
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            data.month,
                            style: TextStyle(
                              fontSize: context.scaleWidth(13),
                              fontWeight: FontWeight.w500,
                              color: AppColors.lightGray,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: maxY / 4 > 0 ? maxY / 4 : 30,
                  getDrawingHorizontalLine: (value) {
                    return const FlLine(
                      color: AppColors.dividerColor,
                      strokeWidth: 1,
                      dashArray: [4, 4],
                    );
                  },
                ),
                borderData: FlBorderData(show: false),
                barGroups: chartData.asMap().entries.map((entry) {
                  final index = entry.key;
                  final data = entry.value;
                  final expenseVal = data.expense;
                  final incomeVal = data.income;
                  final totalVal = expenseVal + incomeVal;

                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: totalVal > 0 ? totalVal : 1.0,
                        width: context.scaleWidth(10),
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(4),
                        rodStackItems: totalVal > 0
                            ? [
                                BarChartRodStackItem(
                                    0, expenseVal, AppColors.messagePink),
                                BarChartRodStackItem(
                                    expenseVal, totalVal, AppColors.primary),
                              ]
                            : [],
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
