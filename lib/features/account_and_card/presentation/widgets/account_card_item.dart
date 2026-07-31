import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:easy_pay_app/core/widgets/card_container.dart';
import 'package:easy_pay_app/features/account_and_card/domain/entities/account_entity.dart';
import 'package:easy_pay_app/features/save_online/presentation/widgets/management_item_card.dart';
import 'package:flutter/material.dart';
import 'package:easy_pay_app/core/theme/app_text_styles.dart';

class AccountCardItem extends StatelessWidget {
  final AccountEntity account;

  const AccountCardItem({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    final holderName = account.bankCards.isNotEmpty
        ? account.bankCards.first.cardHolderName
        : "User";
    return CardContainer(
      child: Column(
        children: [
          ManagementItemCard(
            label: holderName,
            isTitle: true,
            value: account.accountNumber,
          ),
          SizedBox(height: context.scaleHeight(16)),
          ManagementItemCard(
            label: 'available_balance'.tr(),
            value: '\$${account.balance}',
          ),
          SizedBox(height: context.scaleHeight(8)),
          ManagementItemCard(
            label:  'branch'.tr(),
            value: 'Branch'
          ),
        ],
      ),
    );
  }
}
