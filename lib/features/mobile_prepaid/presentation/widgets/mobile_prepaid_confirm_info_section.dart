import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/theme/app_text_styles.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:easy_pay_app/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class MobilePrepaidConfirmInfoSection extends StatelessWidget {
  final String fromCard;
  final String toPhone;
  final String amount;

  const MobilePrepaidConfirmInfoSection({
    super.key,
    required this.fromCard,
    required this.toPhone,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    final fromController = TextEditingController(text: fromCard);
    final toController = TextEditingController(text: toPhone);
    final amountController = TextEditingController(text: amount);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Confirm transaction information'.tr(),
          style: AppTextStyles.bodyMediumSemiBold.copyWith(
            color: AppColors.textLight,
          ),
        ),
        SizedBox(height: context.scaleHeight(16)),

        // From field
        Text(
          'From'.tr(),
          style: AppTextStyles.bodySmall.copyWith(color: AppColors.textLight),
        ),
        SizedBox(height: context.scaleHeight(6)),
        CustomTextField(
          hintText: '',
          controller: fromController,
        ),
        SizedBox(height: context.scaleHeight(16)),

        // To field
        Text(
          'To'.tr(),
          style: AppTextStyles.bodySmall.copyWith(color: AppColors.textLight),
        ),
        SizedBox(height: context.scaleHeight(6)),
        CustomTextField(
          hintText: '',
          controller: toController,
        ),
        SizedBox(height: context.scaleHeight(16)),

        // Amount field
        Text(
          'Amount'.tr(),
          style: AppTextStyles.bodySmall.copyWith(color: AppColors.textLight),
        ),
        SizedBox(height: context.scaleHeight(6)),
        CustomTextField(
          hintText: '',
          controller: amountController,
        ),
      ],
    );
  }
}
