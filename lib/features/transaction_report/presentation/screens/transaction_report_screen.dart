import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/routes/app_routes_name.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/theme/app_text_styles.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:easy_pay_app/core/widgets/header_widget.dart';
import 'package:easy_pay_app/features/bottomNav/presentation/widgets/credit_card_stack.dart';
import 'package:easy_pay_app/features/transaction_report/presentation/widgets/transaction_chart_card.dart';
import 'package:easy_pay_app/features/transaction_report/presentation/widgets/transaction_item_tile.dart';
import 'package:flutter/material.dart';

class TransactionReportScreen extends StatelessWidget {
  const TransactionReportScreen({super.key});

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
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const TransactionChartCard(),
                  SizedBox(height: context.scaleHeight(24)),

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
                  const TransactionItemTile(
                    title: 'Water Bill',
                    subtitle: 'Unsuccessfully',
                    amount: '- \$280',
                    isPositive: false,
                    icon: Icons.water_drop,
                    iconBgColor: AppColors.primary,
                    showDivider: false,
                  ),

                  SizedBox(height: context.scaleHeight(20)),

                  Text(
                    'Yesterday',
                    style: AppTextStyles.titleMediumDark.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: context.scaleWidth(16),
                    ),
                  ),
                  SizedBox(height: context.scaleHeight(8)),
                  const TransactionItemTile(
                    title: 'Income: Salary Oct',
                    amount: '+\$1200',
                    isPositive: true,
                    icon: Icons.confirmation_number_outlined,
                    iconBgColor: AppColors.messagePink,
                    showDivider: true,
                  ),
                  const TransactionItemTile(
                    title: 'Electric Bill',
                    subtitle: 'Successfully',
                    amount: '- \$480',
                    isPositive: false,
                    icon: Icons.power,
                    iconBgColor: AppColors.messageBlue,
                    showDivider: true,
                  ),
                  const TransactionItemTile(
                    title: 'Income : Jane transfers',
                    amount: '+ \$500',
                    isPositive: true,
                    icon: Icons.receipt_long,
                    iconBgColor: AppColors.messageOrange,
                    showDivider: true,
                  ),
                  const TransactionItemTile(
                    title: 'Internet Bill',
                    subtitle: 'Successfully',
                    amount: '- \$100',
                    isPositive: false,
                    icon: Icons.wifi,
                    iconBgColor: AppColors.messageTeal,
                    showDivider: false,
                  ),
                  SizedBox(height: context.scaleHeight(24)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
