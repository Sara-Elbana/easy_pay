import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/theme/app_text_styles.dart';
import 'package:easy_pay_app/features/beneficiary/domain/entities/beneficiary.dart';
import 'package:flutter/material.dart';
import 'beneficiary_item.dart';

class ChooseBeneficiarySection extends StatelessWidget {
  final List<Beneficiary> beneficiaries;
  final Beneficiary? selectedBeneficiary;
  final bool isManualBeneficiary;
  final bool isEnabled;
  final VoidCallback onSelectManual;
  final ValueChanged<Beneficiary> onSelectBeneficiary;
  final VoidCallback? onFindBeneficiary;

  const ChooseBeneficiarySection({
    super.key,
    required this.beneficiaries,
    required this.selectedBeneficiary,
    required this.isManualBeneficiary,
    required this.isEnabled,
    required this.onSelectManual,
    required this.onSelectBeneficiary,
    this.onFindBeneficiary,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Opacity(
          opacity: isEnabled ? 1.0 : 0.4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'choose_beneficiary'.tr(),
                style: AppTextStyles.titleMediumSmallLight,
              ),
              GestureDetector(
                onTap: isEnabled ? onFindBeneficiary : null,
                child: Text(
                  'find_beneficiary'.tr(),
                  style: AppTextStyles.bodyMediumSemiBold.copyWith(color: isEnabled ? AppColors.primary : AppColors.textLight),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 130,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: beneficiaries.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return BeneficiaryItem(
                  beneficiary: null,
                  isSelected: isManualBeneficiary,
                  isEnabled: isEnabled,
                  onTap: onSelectManual,
                );
              }
              final b = beneficiaries[index - 1];
              final isSelected = selectedBeneficiary?.id == b.id;
              return BeneficiaryItem(
                beneficiary: b,
                isSelected: isSelected,
                isEnabled: isEnabled,
                onTap: () => onSelectBeneficiary(b),
              );
            },
          ),
        ),
      ],
    );
  }
}
