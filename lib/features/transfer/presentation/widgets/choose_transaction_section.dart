import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'transaction_type_card.dart';

class ChooseTransactionSection extends StatelessWidget {
  final int? selectedTransactionType;
  final bool isEnabled;
  final ValueChanged<int> onTransactionTypeSelected;

  const ChooseTransactionSection({
    super.key,
    required this.selectedTransactionType,
    required this.isEnabled,
    required this.onTransactionTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Opacity(
          opacity: isEnabled ? 1.0 : 0.4,
          child: Text(
            'choose_transaction'.tr(),
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.textLight,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              final isSelected = selectedTransactionType == index;
              IconData icon;
              String label;
              if (index == 0) {
                icon = Icons.credit_card;
                label = 'transfer_via_card_number'.tr();
              } else if (index == 1) {
                icon = Icons.person;
                label = 'transfer_to_same_bank'.tr();
              } else {
                icon = Icons.account_balance_outlined;
                label = 'transfer_to_another_bank'.tr();
              }

              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: TransactionTypeCard(
                  icon: icon,
                  label: label,
                  isSelected: isSelected,
                  isActiveStyle: isEnabled,
                  isEnabled: isEnabled,
                  onTap: () => onTransactionTypeSelected(index),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
