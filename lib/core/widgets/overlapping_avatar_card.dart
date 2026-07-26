import 'package:easy_pay_app/core/constants/app_assets.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';

class OverlappingAvatarCard extends StatelessWidget {
  final Widget avatar;
  final Widget? title;
  final Widget child;
  final double avatarOffset;
  final double topSpaceHeight;

  const OverlappingAvatarCard({
    super.key,
    required this.avatar,
    this.title,
    required this.child,
    this.avatarOffset = 50.0,
    this.topSpaceHeight = 72.0,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(context.scaleWidth(30)),
              topRight: Radius.circular(context.scaleWidth(30)),
            ),
            boxShadow: const [
              BoxShadow(
                color: AppColors.shadowColor,
                offset: Offset(0, -2),
                blurRadius: 3,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              // Space for avatar
              SizedBox(height: context.scaleHeight(topSpaceHeight)),
              if (title != null) ...[
                title!,
                SizedBox(height: context.scaleHeight(24)),
              ],
              child,
            ],
          ),
        ),

        // Overlapping Avatar
        Positioned(
          top: -context.scaleHeight(50),
          left: 0,
          right: 0,
          child: Center(
            child: ClipOval(
              child: Image.asset(
                AppAssets.avatarImage,
                width: context.scaleWidth(100),
                height: context.scaleHeight(100),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
