import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/theme/app_text_styles.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';

class TimeDepositOption {
  final String duration;
  final String rate;
  final int months;

  const TimeDepositOption({
    required this.duration,
    required this.rate,
    required this.months,
  });
}

class TimeDepositDialog extends StatelessWidget {
  final List<TimeDepositOption> options;
  final String? selectedDuration;
  final ValueChanged<TimeDepositOption> onSelected;

  const TimeDepositDialog({
    super.key,
    required this.options,
    required this.selectedDuration,
    required this.onSelected,
  });

  static Future<void> show({
    required BuildContext context,
    required List<TimeDepositOption> options,
    required String? selectedDuration,
    required ValueChanged<TimeDepositOption> onSelected,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return TimeDepositDialog(
          options: options,
          selectedDuration: selectedDuration,
          onSelected: onSelected,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(context.scaleWidth(24)),
      ),
      backgroundColor: Colors.white,
      child: Container(
        width: context.pctWidth(0.85),
        padding: EdgeInsets.all(context.scaleWidth(24)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(
                Icons.close,
                color: AppColors.gray400,
                size: 22,
              ),
            ),
            Center(
              child: Text(
                'Choose time deposit',
                style: AppTextStyles.transactionAmount.copyWith(
                  fontSize: context.scaleWidth(
                      AppTextStyles.transactionAmount.fontSize ?? 18),
                  color: AppColors.textDark,
                ),
              ),
            ),

            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: context.pctHeight(0.3),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: options.length,
                itemBuilder: (context, index) {
                  final option = options[index];
                  final isSelected = option.duration == selectedDuration;
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Center(
                      child: Text(
                        '${option.duration} (Interest rate ${option.rate})',
                        style: AppTextStyles.titleMediumSmall.copyWith(
                          fontSize: context.scaleWidth(
                              AppTextStyles.titleMediumSmall.fontSize ?? 15),
                          color: isSelected ? AppColors.primary : AppColors.textDark,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                    onTap: () {
                      onSelected(option);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}