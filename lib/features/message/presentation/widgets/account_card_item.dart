import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/features/message/domain/entities/account_entity.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';

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
                style: TextStyle(
                  fontSize: context.scaleWidth(18),
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1E1E1E),
                ),
              ),
              Text(
                account.accountNumber,
                style: TextStyle(
                  fontSize: context.scaleWidth(16),
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1E1E1E),
                ),
              ),
            ],
          ),
          SizedBox(height: context.scaleHeight(16)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'available_balance'.tr(),
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: context.scaleWidth(14),
                ),
              ),
              Text(
                '\$${account.availableBalance.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: context.scaleWidth(14),
                ),
              ),
            ],
          ),
          SizedBox(height: context.scaleHeight(8)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'branch'.tr(),
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: context.scaleWidth(14),
                ),
              ),
              Text(
                account.branch,
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: context.scaleWidth(14),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
