import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:easy_pay_app/core/theme/app_text_styles.dart';

class CardInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const CardInfoRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: context.scaleHeight(16.0),
            horizontal: context.scaleWidth(16.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: AppTextStyles.titleMedium.copyWith(fontSize: context.scaleWidth(AppTextStyles.titleMedium.fontSize ?? 16), color: AppColors.lightGray),
              ),
              Text(
                value,
                style: AppTextStyles.bodyLargeSemiBold.copyWith(fontSize: context.scaleWidth(AppTextStyles.bodyLargeSemiBold.fontSize ?? 16), color: AppColors.primary),
              ),
            ],
          ),
        ),
        Divider(
          color: Colors.grey[200],
          height: 1,
          thickness: 1,
          indent: context.scaleWidth(16),
          endIndent: context.scaleWidth(16),
        ),
      ],
    );
  }
}