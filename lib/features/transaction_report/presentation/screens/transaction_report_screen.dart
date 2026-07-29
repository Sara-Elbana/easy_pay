import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/routes/app_routes_name.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/theme/app_text_styles.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:easy_pay_app/core/widgets/header_widget.dart';
import 'package:easy_pay_app/features/bottomNav/presentation/widgets/credit_card_stack.dart';
import 'package:easy_pay_app/features/transaction_report/domain/entities/transaction_entity.dart';
import 'package:easy_pay_app/features/transaction_report/presentation/cubit/report_cubit.dart';
import 'package:easy_pay_app/features/transaction_report/presentation/cubit/report_state.dart';
import 'package:easy_pay_app/features/transaction_report/presentation/widgets/transaction_chart_card.dart';
import 'package:easy_pay_app/features/transaction_report/presentation/widgets/transaction_item_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionReportScreen extends StatelessWidget {
  const TransactionReportScreen({super.key});

  IconData _getIconForTransaction(TransactionEntity transaction) {
    final cat = (transaction.category ?? transaction.title).toLowerCase();
    if (cat.contains('water')) return Icons.water_drop;
    if (cat.contains('electric') || cat.contains('power')) return Icons.power;
    if (cat.contains('internet') || cat.contains('wifi')) return Icons.wifi;
    if (cat.contains('salary') || cat.contains('income')) {
      return Icons.confirmation_number_outlined;
    }
    if (cat.contains('transfer')) return Icons.receipt_long;
    return Icons.receipt;
  }

  Color _getIconBgColor(int index) {
    final colors = [
      AppColors.primary,
      AppColors.messagePink,
      AppColors.messageBlue,
      AppColors.messageOrange,
      AppColors.messageTeal,
    ];
    return colors[index % colors.length];
  }

  String _formatAmount(double amount) {
    final absVal = amount.abs();
    final formatted =
        absVal.toStringAsFixed(absVal.truncateToDouble() == absVal ? 0 : 2);
    return amount >= 0 ? '+\$$formatted' : '- \$$formatted';
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final double horizontalPadding = context.padMedium;
    final double cardHorizontalPadding = context.scaleWidth(10);
    final double availableWidth = screenWidth - (cardHorizontalPadding * 2);
    final double cardHeight = availableWidth / 1.42;
    final double totalCardStackHeight = cardHeight + 24;
    final double halfCardHeight = totalCardStackHeight / 2;

    final double statusBarHeight = MediaQuery.paddingOf(context).top;
    final double headerHeight = statusBarHeight + context.scaleHeight(56);

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        children: [
          Positioned.fill(
            top: headerHeight + halfCardHeight,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(context.scaleWidth(30)),
                  topRight: Radius.circular(context.scaleWidth(30)),
                ),
              ),
            ),
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: HeaderWidget(
              title: "transaction_report".tr(),
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 20,
                ),
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  } else {
                    Navigator.pushReplacementNamed(
                      context,
                      AppRoutesName.homeScreen,
                    );
                  }
                },
              ),
            ),
          ),

          Positioned(
            top: headerHeight,
            left: cardHorizontalPadding,
            right: cardHorizontalPadding,
            height: totalCardStackHeight,
            child: const CreditCardStack(),
          ),

          Positioned(
            top: headerHeight + totalCardStackHeight + context.scaleHeight(12),
            left: 0,
            right: 0,
            bottom: 0,
            child: BlocBuilder<ReportCubit, ReportState>(
              builder: (context, state) {
                if (state is ReportLoading || state is ReportInitial) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  );
                } else if (state is ReportError) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            state.message,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.bodyMediumGray,
                          ),
                          SizedBox(height: context.scaleHeight(16)),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              context.read<ReportCubit>().getMonthlyReport();
                            },
                            child: const Text(
                              'Retry',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (state is ReportSuccess) {
                  final report = state.report;
                  final todayList = report.reportTransactions.today;
                  final yesterdayList = report.reportTransactions.yesterday;

                  return SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TransactionChartCard(chartData: report.chartData),
                        SizedBox(height: context.scaleHeight(24)),

                        if (todayList.isNotEmpty) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Today',
                                style: AppTextStyles.titleMediumDark.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: context.scaleWidth(16),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: context.scaleHeight(4)),
                          ...todayList.asMap().entries.map((entry) {
                            final index = entry.key;
                            final item = entry.value;
                            return TransactionItemTile(
                              title: item.title,
                              subtitle: item.status,
                              amount: _formatAmount(item.amount),
                              isPositive: item.amount >= 0,
                              icon: _getIconForTransaction(item),
                              iconBgColor: _getIconBgColor(index),
                              showDivider: index < todayList.length - 1,
                            );
                          }),
                          SizedBox(height: context.scaleHeight(20)),
                        ],

                        if (yesterdayList.isNotEmpty) ...[
                          Text(
                            'Yesterday',
                            style: AppTextStyles.titleMediumDark.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: context.scaleWidth(16),
                            ),
                          ),
                          SizedBox(height: context.scaleHeight(8)),
                          ...yesterdayList.asMap().entries.map((entry) {
                            final index = entry.key;
                            final item = entry.value;
                            return TransactionItemTile(
                              title: item.title,
                              subtitle: item.status,
                              amount: _formatAmount(item.amount),
                              isPositive: item.amount >= 0,
                              icon: _getIconForTransaction(item),
                              iconBgColor:
                                  _getIconBgColor(index + todayList.length),
                              showDivider: index < yesterdayList.length - 1,
                            );
                          }),
                          SizedBox(height: context.scaleHeight(24)),
                        ],
                      ],
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
