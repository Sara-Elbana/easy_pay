import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/theme/app_text_styles.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';

class AmountButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final bool isEnabled;
  final VoidCallback onTap;

  const AmountButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.isEnabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: Opacity(
        opacity: isEnabled ? 1.0 : 0.5,
        child: Container(
          width: context.scaleWidth(100),
          height: context.scaleHeight(60),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.white,
            borderRadius: BorderRadius.circular(context.scaleWidth(15)),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.inputBorder,
              width: 1.5,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: AppTextStyles.bodyLargeSemiBold.copyWith(
              fontSize: context.scaleWidth(AppTextStyles.bodyLargeSemiBold.fontSize ?? 16),
              color: isSelected ? Colors.white : AppColors.lightGray,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ),
    );
  }
}
