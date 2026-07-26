import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/exchange_rate.dart';
import 'flag_widget.dart';
import 'package:easy_pay_app/core/theme/app_text_styles.dart';

class ExchangeRateRow extends StatelessWidget {
  final ExchangeRate rate;

  const ExchangeRateRow({
    super.key,
    required this.rate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.scaleWidth(24),
        vertical: context.scaleHeight(14),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Row(
              children: [
                FlagWidget(
                  flagAsset: rate.flagAsset,
                ),
                SizedBox(width: context.scaleWidth(16)),
                Expanded(
                  child: Text(
                    rate.country,
                    style: AppTextStyles.titleMedium.copyWith(fontSize: context.scaleWidth(AppTextStyles.titleMedium.fontSize ?? 16), color: AppColors.textDark, fontFamily: 'Poppins'),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              rate.buy.toString(),
              textAlign: TextAlign.right,
              style: AppTextStyles.titleMedium.copyWith(fontSize: context.scaleWidth(AppTextStyles.titleMedium.fontSize ?? 16), color: AppColors.textDark, fontFamily: 'Poppins'),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              rate.sell.toString(),
              textAlign: TextAlign.right,
              style: AppTextStyles.titleMedium.copyWith(fontSize: context.scaleWidth(AppTextStyles.titleMedium.fontSize ?? 16), color: AppColors.textDark, fontFamily: 'Poppins'),
            ),
          ),
        ],
      ),
    );
  }
}