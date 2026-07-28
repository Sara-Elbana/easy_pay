import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/theme/app_text_styles.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TransactionChartCard extends StatelessWidget {
  const TransactionChartCard({super.key});

  @override
  Widget build(BuildContext context) {
    final List<_MonthBarData> barDataList = [
      _MonthBarData(month: 'Jan', bottom: 20, middle: 20, top: 20),
      _MonthBarData(month: 'Feb', bottom: 25, middle: 30, top: 35),
      _MonthBarData(month: 'Mar', bottom: 30, middle: 35, top: 45),
      _MonthBarData(month: 'Apr', bottom: 25, middle: 25, top: 30, isActive: true),
      _MonthBarData(month: 'May', bottom: 15, middle: 20, top: 20),
      _MonthBarData(month: 'Jun', bottom: 30, middle: 30, top: 35),
    ];

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
                '1000',
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
                maxY: 120,
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
                        if (index < 0 || index >= barDataList.length) {
                          return const SizedBox.shrink();
                        }
                        final data = barDataList[index];
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            data.month,
                            style: TextStyle(
                              fontSize: context.scaleWidth(13),
                              fontWeight: data.isActive
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              color: data.isActive
                                  ? AppColors.primary
                                  : AppColors.lightGray,
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
                  horizontalInterval: 30,
                  getDrawingHorizontalLine: (value) {
                    return const FlLine(
                      color: AppColors.dividerColor,
                      strokeWidth: 1,
                      dashArray: [4, 4],
                    );
                  },
                ),
                borderData: FlBorderData(show: false),
                barGroups: barDataList.asMap().entries.map((entry) {
                  final index = entry.key;
                  final data = entry.value;
                  final bottomVal = data.bottom;
                  final middleVal = data.middle;
                  final topVal = data.top;
                  final totalVal = bottomVal + middleVal + topVal;

                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: totalVal,
                        width: context.scaleWidth(10),
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(4),
                        rodStackItems: [
                          BarChartRodStackItem(
                              0, bottomVal, AppColors.messagePink),
                          BarChartRodStackItem(bottomVal,
                              bottomVal + middleVal, const Color(0xFFB9B7E8)),
                          BarChartRodStackItem(
                              bottomVal + middleVal, totalVal, AppColors.primary),
                        ],
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

class _MonthBarData {
  final String month;
  final double bottom;
  final double middle;
  final double top;
  final bool isActive;

  _MonthBarData({
    required this.month,
    required this.bottom,
    required this.middle,
    required this.top,
    this.isActive = false,
  });
}
