import 'package:easy_pay_app/core/constants/app_assets.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

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
          'Push Puttichai',
          style: TextStyle(
            fontSize: context.scaleWidth(18),
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}