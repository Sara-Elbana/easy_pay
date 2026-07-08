import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/theme/text_styles.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String supTitle;
  CustomDialog({super.key, required this.title, required this.supTitle});

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Center(
        child: Text(
          "Had very little!",
          style: AppTextStyles.titleLarge.copyWith(color: AppColors.black),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,

            style: AppTextStyles.titleLarge.copyWith(color: AppColors.black),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: size.height * 0.02),
          Text(
            supTitle,

            style: AppTextStyles.bodyLarge.copyWith(color: AppColors.gray800),
          ),
        ],
      ),
    );
  }
}
