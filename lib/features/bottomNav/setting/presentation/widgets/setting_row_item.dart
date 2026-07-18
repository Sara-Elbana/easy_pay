import 'package:flutter/material.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';

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
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textDark,
                      height: 24 / 16,
                    ),
                  ),
                ),

                if (subtitle != null) ...[
                  Text(
                    subtitle!,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF979797),
                      height: 16 / 12,
                    ),
                  ),
                  const SizedBox(width: 8),
                ],

                if (trailing != null)
                  trailing!
                else if (showArrow)
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: AppColors.gray,
                  ),
              ],
            ),
          ),
          const Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFFECECEC),
          ),
        ],
      ),
    );
  }
}