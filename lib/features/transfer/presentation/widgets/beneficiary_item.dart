import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/beneficiary.dart';

class BeneficiaryItem extends StatelessWidget {
  final Beneficiary? beneficiary;
  final bool isSelected;
  final bool isEnabled;
  final VoidCallback onTap;

  const BeneficiaryItem({
    super.key,
    required this.beneficiary,
    required this.isSelected,
    this.isEnabled = true,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isAddButton = beneficiary == null;

    final childWidget = SizedBox(
      width: 110,
      child: Column(
        children: [
          Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected && isEnabled ? AppColors.primary : Colors.transparent,
                width: 2.5,
              ),
            ),
            padding: isSelected && isEnabled ? const EdgeInsets.all(3) : EdgeInsets.zero,
            child: isAddButton
                ? Container(
                    decoration: const BoxDecoration(
                      color: AppColors.gray100,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.add,
                      color: AppColors.textLight,
                      size: 32,
                    ),
                  )
                : CircleAvatar(
                    radius: 40,
                    backgroundColor: AppColors.gray200,
                    backgroundImage: beneficiary!.avatarUrl != null
                        ? NetworkImage(beneficiary!.avatarUrl!)
                        : null,
                    child: beneficiary!.avatarUrl == null
                        ? Text(
                            beneficiary!.name.substring(0, 1).toUpperCase(),
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark,
                            ),
                          )
                        : null,
                  ),
          ),
          const SizedBox(height: 8),
          Text(
            isAddButton ? ' ' : beneficiary!.name,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isSelected && isEnabled ? FontWeight.bold : FontWeight.w500,
              color: isSelected && isEnabled
                  ? AppColors.primary
                  : (isEnabled ? AppColors.textDark : AppColors.textLight.withAlpha(50)),
            ),
          ),
        ],
      ),
    );

    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: isEnabled
          ? childWidget
          : Opacity(
              opacity: 0.4,
              child: childWidget,
            ),
    );
  }
}
