import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';

class ExchangeRateHeader extends StatelessWidget {
  const ExchangeRateHeader({super.key});

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
              'country'.tr(),
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: context.scaleWidth(14),
                fontWeight: FontWeight.w600,
                color: AppColors.gray400,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'buy'.tr(),
              textAlign: TextAlign.right,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: context.scaleWidth(14),
                fontWeight: FontWeight.w600,
                color: AppColors.gray400,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'sell'.tr(),
              textAlign: TextAlign.right,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: context.scaleWidth(14),
                fontWeight: FontWeight.w600,
                color: AppColors.gray400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
