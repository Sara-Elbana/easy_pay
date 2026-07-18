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
                : ClipOval(
                    child: beneficiary!.avatarUrl != null
                        ? Image.network(
                            beneficiary!.avatarUrl!,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                width: 80,
                                height: 80,
                                color: AppColors.gray200,
                                alignment: Alignment.center,
                                child: const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.0,
                                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                                  ),
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 80,
                                height: 80,
                                color: AppColors.gray200,
                                alignment: Alignment.center,
                                child: Text(
                                  beneficiary!.name.isNotEmpty
                                      ? beneficiary!.name.substring(0, 1).toUpperCase()
                                      : '?',
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textDark,
                                  ),
                                ),
                              );
                            },
                          )
                        : Container(
                            width: 80,
                            height: 80,
                            color: AppColors.gray200,
                            alignment: Alignment.center,
                            child: Text(
                              beneficiary!.name.isNotEmpty
                                  ? beneficiary!.name.substring(0, 1).toUpperCase()
                                  : '?',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textDark,
                              ),
                            ),
                          ),
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
