import 'package:easy_pay_app/core/theme/app_colors.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: 16),
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
                    borderRadius: BorderRadius.circular(16)),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () => onTabChanged(0),
              child: const Text('Account',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(width: 16),
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
                    borderRadius: BorderRadius.circular(16)),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () => onTabChanged(1),
              child: const Text('Card',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}
