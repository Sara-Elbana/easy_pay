import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/features/message/domain/entities/account_entity.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:easy_pay_app/core/theme/app_text_styles.dart';

class AccountCardItem extends StatelessWidget {
  final AccountEntity account;

  const AccountCardItem({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
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
                account.title,
                style: AppTextStyles.transactionAmount.copyWith(fontSize: context.scaleWidth(AppTextStyles.transactionAmount.fontSize ?? 18), color: AppColors.offBlack),
              ),
              Text(
                account.accountNumber,
                style: AppTextStyles.bodyLarge.copyWith(fontSize: context.scaleWidth(AppTextStyles.bodyLarge.fontSize ?? 16), color: AppColors.offBlack),
              ),
            ],
          ),
          SizedBox(height: context.scaleHeight(16)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'available_balance'.tr(),
                style: AppTextStyles.bodyMedium.copyWith(fontSize: context.scaleWidth(AppTextStyles.bodyMedium.fontSize ?? 14), color: AppColors.lightGray),
              ),
              Text(
                '\$${account.availableBalance.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                style: AppTextStyles.bodyMediumSemiBold.copyWith(fontSize: context.scaleWidth(AppTextStyles.bodyMediumSemiBold.fontSize ?? 14), color: AppColors.primary),
              ),
            ],
          ),
          SizedBox(height: context.scaleHeight(8)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'branch'.tr(),
                style: AppTextStyles.bodyMedium.copyWith(fontSize: context.scaleWidth(AppTextStyles.bodyMedium.fontSize ?? 14), color: AppColors.lightGray),
              ),
              Text(
                account.branch,
                style: AppTextStyles.bodyMediumSemiBold.copyWith(fontSize: context.scaleWidth(AppTextStyles.bodyMediumSemiBold.fontSize ?? 14), color: AppColors.primary),
              ),
            ],
          ),
        ],
      ),
    );
  }
}