import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'amount_button.dart';

class AmountSelectorGrid extends StatelessWidget {
  final int? selectedAmount;
  final bool isOtherSelected;
  final bool isEnabled;
  final ValueChanged<int?> onAmountSelected;
  final VoidCallback onOtherSelected;

  const AmountSelectorGrid({
    super.key,
    required this.selectedAmount,
    required this.isOtherSelected,
    required this.isEnabled,
    required this.onAmountSelected,
    required this.onOtherSelected,
  });

  @override
  Widget build(BuildContext context) {
    final List<int> amounts = [10, 50, 100, 150, 200];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: amounts.length + 1,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: context.scaleWidth(12),
        mainAxisSpacing: context.scaleHeight(16),
        childAspectRatio: 100 / 60,
      ),
      itemBuilder: (context, index) {
        if (index < amounts.length) {
          final amt = amounts[index];
          final isSelected = !isOtherSelected && selectedAmount == amt;
          return AmountButton(
            text: '\$$amt',
            isSelected: isSelected,
            isEnabled: isEnabled,
            onTap: () => onAmountSelected(amt),
          );
        } else {
          return AmountButton(
            text: 'other'.tr(),
            isSelected: isOtherSelected,
            isEnabled: isEnabled,
            onTap: onOtherSelected,
          );
        }
      },
    );
  }
}
