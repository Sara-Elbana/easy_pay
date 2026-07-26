import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/features/account_and_card/domain/entities/card_entity.dart';
import 'package:easy_pay_app/features/account_and_card/presentation/widgets/card_info_row.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:easy_pay_app/core/theme/app_text_styles.dart';

class CardDetailsScreen extends StatelessWidget {

  const CardDetailsScreen({super.key, });

  @override
  Widget build(BuildContext context) {
    final card = ModalRoute.of(context)!.settings.arguments as CardEntity;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'card_details'.tr(),
          style: AppTextStyles.titleLargeMedium.copyWith(
            fontSize: context.scaleWidth(AppTextStyles.titleLargeMedium.fontSize ?? 20),
            color: Colors.black87,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          SizedBox(height: context.scaleHeight(16)),
          CardInfoRow(label: 'name'.tr(), value: card.cardHolderName),
          CardInfoRow(label: 'card_number'.tr(), value: card.maskedCardNumber),
          CardInfoRow(label: 'card_type'.tr(), value: card.cardType),
          CardInfoRow(label: 'good_thru'.tr(), value: card.expirationDate),
          CardInfoRow(
            label: 'status'.tr(),
            value: card.isActive ? 'Active'.tr() : 'Inactive'.tr(),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(bottom: context.scaleHeight(40.0)),
            child: TextButton(
              onPressed: () {
              },
              child: Text(
                'delete_card'.tr(),
                style: AppTextStyles.bodyLargeSemiBold.copyWith(
                  fontSize: context.scaleWidth(AppTextStyles.bodyLargeSemiBold.fontSize ?? 16),
                  color: Colors.redAccent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}