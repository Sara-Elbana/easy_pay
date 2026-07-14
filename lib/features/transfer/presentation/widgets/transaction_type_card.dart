import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class TransactionTypeCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final bool isActiveStyle; // True if account is chosen -> solid fill, False -> outline
  final bool isEnabled;
  final VoidCallback onTap;

  const TransactionTypeCard({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.isActiveStyle,
    this.isEnabled = true,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool useSolidFill = isSelected && isActiveStyle && isEnabled;
    final bool useOutline = isSelected && !isActiveStyle && isEnabled;

    Color backgroundColor = AppColors.gray100;
    Border? border;

    if (!isEnabled) {
      backgroundColor = AppColors.gray100;
      border = Border.all(color: AppColors.gray200, width: 2);
    } else if (useSolidFill) {
      backgroundColor = AppColors.primary;
    } else if (useOutline) {
      backgroundColor = Colors.white;
      border = Border.all(color: AppColors.primary, width: 2);
    } else {
      border = Border.all(color: Colors.transparent, width: 2);
    }

    final Color contentColor = !isEnabled
        ? AppColors.textLight.withValues(alpha: 0.5)
        : (useSolidFill
            ? Colors.white
            : (useOutline ? AppColors.primary : AppColors.textLight));

    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 120,
        height: 110,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(15),
          border: border,
          boxShadow: useSolidFill
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              icon,
              color: contentColor,
              size: 28,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                height: 1.2,
                fontWeight: FontWeight.bold,
                color: contentColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
