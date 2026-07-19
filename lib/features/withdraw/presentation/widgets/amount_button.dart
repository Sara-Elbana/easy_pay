import 'package:easy_pay_app/core/theme/app_colors.dart';
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
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                offset: const Offset(0, 5),
                blurRadius: 30,
                spreadRadius: 0,
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: context.scaleWidth(16),
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : const Color(0xFF989898),
            ),
          ),
        ),
      ),
    );
  }
}
