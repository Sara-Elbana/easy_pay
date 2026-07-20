import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/widgets/transaction_type_card.dart';
import 'package:flutter/material.dart';

class AddBeneficiaryTypeSelector extends StatelessWidget {
  final int? selectedType;
  final bool isEnabled;
  final ValueChanged<int> onTypeSelected;

  const AddBeneficiaryTypeSelector({
    super.key,
    required this.selectedType,
    this.isEnabled = true,
    required this.onTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isEnabled ? 1.0 : 0.4,
      child: SizedBox(
        height: 110, // Match height of card
        child: Row(
          children: [
            Expanded(
              child: TransactionTypeCard(
                icon: Icons.credit_card,
                label: 'transfer_via_card_number'.tr().replaceAll('\n', ' '),
                isSelected: selectedType == 0,
                isActiveStyle: isEnabled,
                isEnabled: isEnabled,
                selectedColor: AppColors.primary,
                unselectedColor: const Color(0xFFE0E0E0),
                unselectedContentColor: Colors.white,
                onTap: () => onTypeSelected(0),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TransactionTypeCard(
                icon: Icons.person,
                label: 'transfer_to_same_bank'.tr().replaceAll('\n', ' '),
                isSelected: selectedType == 1,
                isActiveStyle: isEnabled,
                isEnabled: isEnabled,
                selectedColor: AppColors.primary,
                unselectedColor: const Color(0xFFE0E0E0),
                unselectedContentColor: Colors.white,
                onTap: () => onTypeSelected(1),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TransactionTypeCard(
                icon: Icons.account_balance_outlined,
                label: 'transfer_to_another_bank'.tr().replaceAll('\n', ' '),
                isSelected: selectedType == 2,
                isActiveStyle: isEnabled,
                isEnabled: isEnabled,
                selectedColor: const Color(0xFFFFAF2A),
                unselectedColor: const Color(0xFFE0E0E0),
                unselectedContentColor: Colors.white,
                onTap: () => onTypeSelected(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
