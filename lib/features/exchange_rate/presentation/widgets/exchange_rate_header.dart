import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:easy_pay_app/core/theme/app_text_styles.dart';

class ExchangeRateHeader extends StatelessWidget {
  final String title1;
  final String title2;
  final String title3;
  const ExchangeRateHeader({super.key, required this.title1, required this.title2, required this.title3});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.scaleWidth(24),
        vertical: context.scaleHeight(12),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Text(
              title1.tr(),
              style: AppTextStyles.bodyMediumSemiBold.copyWith(fontSize: context.scaleWidth(AppTextStyles.bodyMediumSemiBold.fontSize ?? 14), color: AppColors.gray400, fontFamily: 'Poppins'),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              title2.tr(),
              textAlign: TextAlign.right,
              style: AppTextStyles.bodyMediumSemiBold.copyWith(fontSize: context.scaleWidth(AppTextStyles.bodyMediumSemiBold.fontSize ?? 14), color: AppColors.gray400, fontFamily: 'Poppins'),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              title3.tr(),
              textAlign: TextAlign.right,
              style: AppTextStyles.bodyMediumSemiBold.copyWith(fontSize: context.scaleWidth(AppTextStyles.bodyMediumSemiBold.fontSize ?? 14), color: AppColors.gray400, fontFamily: 'Poppins'),
            ),
          ),
        ],
      ),
    );
  }
}