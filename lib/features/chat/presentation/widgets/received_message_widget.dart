import 'package:flutter/material.dart';
import 'package:easy_pay_app/core/core.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';

class ReceivedMessageWidget extends StatelessWidget {
  final List<String> texts;
  const ReceivedMessageWidget({super.key, required this.texts});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: context.scaleWidth(250)),
        padding: EdgeInsets.all(context.scaleWidth(12)),
        decoration: BoxDecoration(
          color: AppColors.chatBgColor,
          borderRadius: BorderRadius.circular(context.scaleWidth(15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: texts
              .map((t) => Text(
            t,
            style: AppTextStyles.labelLarge.copyWith(
              fontSize: context.scaleWidth(AppTextStyles.labelLarge.fontSize ?? 14),
              color: AppColors.textDark,
              fontFamily: 'Poppins',
            ),
          ))
              .toList(),
        ),
      ),
    );
  }
}