import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/theme/app_text_styles.dart';

class SettingRowItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final bool showArrow;
  final Widget? trailing;

  const SettingRowItem({
    super.key,
    required this.title,
    this.subtitle,
    this.onTap,
    this.showArrow = true,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: context.scaleHeight(16)),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: AppTextStyles.titleMedium.copyWith(fontSize: context.scaleWidth(AppTextStyles.titleMedium.fontSize ?? 16), color: AppColors.textDark, height: 24 / 16, fontFamily: 'Poppins'),
                  ),
                ),

                if (subtitle != null) ...[
                  Text(
                    subtitle!,
                    style: AppTextStyles.bodySmallSemiBold.copyWith(fontSize: context.scaleWidth(AppTextStyles.bodySmallSemiBold.fontSize ?? 12), color: AppColors.gray, height: 16 / 12, fontFamily: 'Poppins'),
                  ),
                  SizedBox(width: context.scaleWidth(8)),
                ],

                if (trailing != null)
                  trailing!
                else if (showArrow)
                  Icon(
                    Icons.arrow_forward_ios,
                    size: context.scaleWidth(14),
                    color: AppColors.gray,
                  ),
              ],
            ),
          ),
          const Divider(
            height: 1,
            thickness: 1,
            color: AppColors.dividerColor,
          ),
        ],
      ),
    );
  }
}