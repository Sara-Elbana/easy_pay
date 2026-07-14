import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/transfer_card.dart';

class AccountDropdown extends StatelessWidget {
  final List<TransferCard> cards;
  final TransferCard? selectedCard;
  final ValueChanged<TransferCard?> onChanged;

  const AccountDropdown({
    super.key,
    required this.cards,
    required this.selectedCard,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.inputBorder,
              width: 1.5,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<TransferCard?>(
              value: selectedCard,
              hint: Row(
                children: [
                  Expanded(
                    child: Text(
                      'choose_account_card'.tr(),
                      style: const TextStyle(
                        color: AppColors.textLight,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              isExpanded: true,
              icon: const Icon(
                Icons.unfold_more,
                color: AppColors.textLight,
                size: 20,
              ),
              onChanged: onChanged,
              items: [
                ...cards.map((card) {
                  return DropdownMenuItem<TransferCard?>(
                    value: card,
                    child: Text(
                      card.cardNumber,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textDark,
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
        if (selectedCard != null) ...[
          const SizedBox(height: 8),
          Text(
            selectedCard!.balance,
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ],
    );
  }
}
