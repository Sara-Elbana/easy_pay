import 'package:flutter/material.dart';
import 'package:easy_pay_app/core/core.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';

class SentMessageWidget extends StatelessWidget {
  final String text;

  const SentMessageWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        constraints: BoxConstraints(maxWidth: context.scaleWidth(200)),
        padding: EdgeInsets.all(context.scaleWidth(12)),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(context.scaleWidth(15)),
        ),
        child: Text(
          text,
          style: AppTextStyles.labelLarge.copyWith(
            fontSize: context.scaleWidth(
                AppTextStyles.labelLarge.fontSize ?? 14),
            color: Colors.white,
            fontFamily: 'Poppins',
          ),
        ),
      ),
    );
  }
}