import 'package:flutter/material.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';

class CardContainer extends StatelessWidget {
  final Widget child;

  const CardContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: theme.brightness == Brightness.dark
          ? AppColors.gray800
          : Colors.white,
      elevation: 4,
      shadowColor: AppColors.gray200.withAlpha(50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(context.scaleWidth(24)),
      ),
      child: Padding(
        padding: EdgeInsets.all(context.padHigh),
        child: child,
      ),
    );
  }
}