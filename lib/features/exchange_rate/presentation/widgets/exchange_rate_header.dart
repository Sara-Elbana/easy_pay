import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';

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
              title2.tr(),
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
              title3.tr(),
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
