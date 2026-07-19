import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';

class ToggleTabs extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabChanged;

  const ToggleTabs({
    super.key,
    required this.selectedIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: context.scaleWidth(16)),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: selectedIndex == 0
                    ? AppColors.primary
                    : const Color(0xFFF3F4F9),
                foregroundColor:
                    selectedIndex == 0 ? AppColors.white : Colors.grey[600],
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(context.scaleWidth(16))),
                padding: EdgeInsets.symmetric(vertical: context.scaleHeight(16)),
              ),
              onPressed: () => onTabChanged(0),
              child: Text(
                'account_tab'.tr(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(width: context.scaleWidth(16)),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: selectedIndex == 1
                    ? AppColors.primary
                    : const Color(0xFFF3F4F9),
                foregroundColor:
                    selectedIndex == 1 ? AppColors.white : Colors.grey[600],
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(context.scaleWidth(16))),
                padding: EdgeInsets.symmetric(vertical: context.scaleHeight(16)),
              ),
              onPressed: () => onTabChanged(1),
              child: Text(
                'card_tab'.tr(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
