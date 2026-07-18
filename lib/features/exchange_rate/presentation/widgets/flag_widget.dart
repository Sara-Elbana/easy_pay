import 'package:flutter/material.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';

class FlagWidget extends StatelessWidget {
  final String flagAsset;

  const FlagWidget({
    super.key,
    required this.flagAsset,
  });

  @override
  Widget build(BuildContext context) {
    final double width = context.scaleWidth(40);
    final double height = context.scaleHeight(30);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.gray100,
        borderRadius: BorderRadius.circular(context.scaleWidth(4)),
        border: Border.all(
          color: AppColors.gray200,
          width: 0.5,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(context.scaleWidth(4)),
        child: Image.asset(
          flagAsset,
          width: width,
          height: height,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Center(
              child: Icon(
                Icons.flag,
                color: AppColors.textLight,
                size: 16,
              ),
            );
          },
        ),
      ),
    );
  }
}
