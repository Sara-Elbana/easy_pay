import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SelectionBox extends StatelessWidget {
  final String value;
  final String placeholder;
  final bool isEnabled;
  final VoidCallback onTap;

  const SelectionBox({
    super.key,
    required this.value,
    required this.placeholder,
    required this.isEnabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasValue = value.trim().isNotEmpty;

    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: InputDecorator(
        isEmpty: !hasValue,
        decoration: InputDecoration(
          filled: true,
          fillColor: isEnabled ? Colors.white : AppColors.gray100.withAlpha(50),
          enabled: isEnabled,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: AppColors.inputBorder, width: 1.5),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: AppColors.inputBorder.withAlpha(50), width: 1.5),
          ),
          suffixIcon: Icon(
            hasValue ? Icons.chevron_right : Icons.keyboard_arrow_down,
            color: isEnabled ? AppColors.textLight : AppColors.gray400,
            size: 20,
          ),
        ),
        child: Text(
          hasValue ? value : placeholder,
          style: TextStyle(
            fontSize: 16,
            fontWeight: hasValue ? FontWeight.w500 : FontWeight.w400,
            color: hasValue
                ? AppColors.textDark
                : (isEnabled ? AppColors.textLight : AppColors.textLight.withAlpha(50)),
          ),
        ),
      ),
    );
  }
}
