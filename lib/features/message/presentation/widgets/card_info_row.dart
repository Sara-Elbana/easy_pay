import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';

class CardInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const CardInfoRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: context.scaleHeight(16.0),
            horizontal: context.scaleWidth(16.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: context.scaleWidth(16),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: context.scaleWidth(16),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: Colors.grey[200],
          height: 1,
          thickness: 1,
          indent: context.scaleWidth(16),
          endIndent: context.scaleWidth(16),
        ),
      ],
    );
  }
}