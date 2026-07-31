import 'package:easy_pay_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class ManagementItemCard extends StatelessWidget {
  final String label;
  final String value;
  final bool isTitle ;
  const ManagementItemCard({super.key, required this.label, required this.value,this.isTitle = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isTitle
              ? AppTextStyles.titleMediumDarkOffBlack
              : AppTextStyles.bodyMediumGray,
        ),
        Text(
          value,
          style: isTitle
              ? AppTextStyles.titleMediumDarkOffBlack
              : AppTextStyles.bodyMediumPrimary,
        ),
      ],
    );
  }
}
