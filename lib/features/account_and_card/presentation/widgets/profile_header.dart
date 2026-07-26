import 'package:easy_pay_app/core/constants/app_assets.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:easy_pay_app/core/theme/app_text_styles.dart';

class ProfileHeader extends StatelessWidget {
  final String userName;
  const ProfileHeader({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: context.scaleWidth(50),
          backgroundColor: Colors.grey,
          backgroundImage: const AssetImage(AppAssets.avatarImage),
        ),
        SizedBox(height: context.scaleHeight(12)),
        Text(
          userName,
          style: AppTextStyles.transactionAmount.copyWith(
              fontSize: context
                  .scaleWidth(AppTextStyles.transactionAmount.fontSize ?? 18),
              color: AppColors.primary),
        ),
      ],
    );
  }
}
