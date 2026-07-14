import 'package:easy_pay_app/core/core.dart';
import 'package:flutter/material.dart';

class TermsAndConditionsWidget extends StatelessWidget {
  final bool value;
  final bool enabled;
  final ValueChanged<bool> onChanged;

  final String normalText;
  final String highlightedText;

  const TermsAndConditionsWidget({
    super.key,
    required this.value,
    required this.enabled,
    required this.onChanged,
    required this.normalText,
    required this.highlightedText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: value,
          fillColor: WidgetStateProperty.resolveWith(
                (_) => Colors.white,
          ),
          checkColor: AppColors.primary,
          activeColor: AppColors.primary,
          side: WidgetStateBorderSide.resolveWith(
                (states) => BorderSide(
              color: states.contains(WidgetState.selected)
                  ? AppColors.primary
                  : Colors.grey,
              width: 1.4,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          onChanged: enabled
              ? (checked) => onChanged(checked ?? false)
              : null,
        ),
        Expanded(
          child: GestureDetector(
            onTap: enabled ? () => onChanged(!value) : null,
            child: RichText(
              text: TextSpan(
                style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textDark,fontWeight: FontWeight.w400),
                children: [
                  TextSpan(text: normalText),
                  TextSpan(
                    text: highlightedText,
                    style:AppTextStyles.titleMedium.copyWith(color: AppColors.primary,fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}