import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class TransactionTypeCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final bool isActiveStyle; // True if account is chosen -> solid fill, False -> outline
  final bool isEnabled;
  final VoidCallback onTap;

  // Customization options for reusability
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? selectedContentColor;
  final Color? unselectedContentColor;
  final double? width;
  final double? height;

  const TransactionTypeCard({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.isActiveStyle,
    this.isEnabled = true,
    required this.onTap,
    this.selectedColor,
    this.unselectedColor,
    this.selectedContentColor,
    this.unselectedContentColor,
    this.width,
    this.height,
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
      backgroundColor = selectedColor ?? AppColors.primary;
    } else if (useOutline) {
      backgroundColor = Colors.white;
      border = Border.all(color: selectedColor ?? AppColors.primary, width: 2);
    } else {
      backgroundColor = unselectedColor ?? AppColors.gray100;
      border = Border.all(color: Colors.transparent, width: 2);
    }

    final Color contentColor = !isEnabled
        ? AppColors.textLight.withAlpha(50)
        : (useSolidFill
            ? (selectedContentColor ?? Colors.white)
            : (useOutline
                ? (selectedContentColor ?? AppColors.primary)
                : (unselectedContentColor ?? AppColors.textLight)));

    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: width ?? 120,
        height: height ?? 110,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(15),
          border: border,
          boxShadow: useSolidFill
              ? [
                  BoxShadow(
                    color: (selectedColor ?? AppColors.primary).withAlpha(30),
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
