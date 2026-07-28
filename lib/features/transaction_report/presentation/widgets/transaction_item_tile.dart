import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/theme/app_text_styles.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';

class TransactionItemTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String amount;
  final bool isPositive;
  final IconData icon;
  final Color iconBgColor;
  final bool showDivider;

  const TransactionItemTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.amount,
    required this.isPositive,
    required this.icon,
    required this.iconBgColor,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: context.scaleHeight(10)),
          child: Row(
            children: [
              Container(
                width: context.scaleWidth(44),
                height: context.scaleWidth(44),
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(context.scaleWidth(12)),
                  boxShadow: [
                    BoxShadow(
                      color: iconBgColor.withValues(alpha: 0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: context.scaleWidth(20),
                ),
              ),
              SizedBox(width: context.scaleWidth(14)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.titleMediumDark.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: context.scaleWidth(15),
                      ),
                    ),
                    if (subtitle != null && subtitle!.isNotEmpty) ...[
                      SizedBox(height: context.scaleHeight(2)),
                      Text(
                        subtitle!,
                        style: AppTextStyles.bodySmallGray.copyWith(
                          color: AppColors.gray500,
                          fontSize: context.scaleWidth(12),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Text(
                amount,
                style: TextStyle(
                  fontSize: context.scaleWidth(16),
                  fontWeight: FontWeight.bold,
                  color: isPositive ? AppColors.primary : AppColors.messagePink,
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            color: AppColors.dividerColor,
            indent: context.scaleWidth(58),
          ),
      ],
    );
  }
}
