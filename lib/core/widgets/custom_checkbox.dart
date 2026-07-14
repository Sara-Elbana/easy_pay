import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final String? label;
  final bool isEnabled;

  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final Color checkboxColor = value
        ? (isEnabled ? AppColors.primary : AppColors.gray200)
        : Colors.transparent;
    final Color borderColor = value
        ? (isEnabled ? AppColors.primary : AppColors.gray200)
        : (isEnabled ? AppColors.inputBorder : AppColors.gray200);

    return GestureDetector(
      onTap: isEnabled ? () => onChanged(!value) : null,
      child: Opacity(
        opacity: isEnabled ? 1.0 : 0.5,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: checkboxColor,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: borderColor,
                  width: 1.5,
                ),
              ),
              child: value
                  ? const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    )
                  : null,
            ),
            if (label != null) ...[
              const SizedBox(width: 10),
              Text(
                label!,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
