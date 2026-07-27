import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:easy_pay_app/features/account_and_card/domain/entities/account_entity.dart';
import 'package:flutter/material.dart';
import 'package:easy_pay_app/core/theme/app_text_styles.dart';

class AccountCardItem extends StatelessWidget {
  final AccountEntity account;

  const AccountCardItem({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    final holderName = account.bankCards.isNotEmpty
        ? account.bankCards.first.cardHolderName
        : "User";
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: context.scaleWidth(16),
        vertical: context.scaleHeight(8),
      ),
      padding: EdgeInsets.all(context.scaleWidth(20)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.scaleWidth(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(500),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                holderName,
                style: AppTextStyles.titleMediumDarkOffBlack,
              ),
              Text(
                account.accountNumber,
                style: AppTextStyles.titleMediumDarkOffBlack,
              ),
            ],
          ),
          SizedBox(height: context.scaleHeight(16)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'available_balance'.tr(),
                style: AppTextStyles.bodyMediumGray,
              ),
              Text(
                '\$${account.balance}',
                style: AppTextStyles.bodyMediumPrimary,
              ),
            ],
          ),
          SizedBox(height: context.scaleHeight(8)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'branch'.tr(),
                style: AppTextStyles.bodyMediumGray,
              ),
              const Text(
                "Branch",
                style: AppTextStyles.bodyMediumPrimary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
