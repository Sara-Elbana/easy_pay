import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/beneficiary.dart';
import 'beneficiary_item.dart';

class ChooseBeneficiarySection extends StatelessWidget {
  final List<Beneficiary> beneficiaries;
  final Beneficiary? selectedBeneficiary;
  final bool isManualBeneficiary;
  final bool isEnabled;
  final VoidCallback onSelectManual;
  final ValueChanged<Beneficiary> onSelectBeneficiary;

  const ChooseBeneficiarySection({
    super.key,
    required this.beneficiaries,
    required this.selectedBeneficiary,
    required this.isManualBeneficiary,
    required this.isEnabled,
    required this.onSelectManual,
    required this.onSelectBeneficiary,
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
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textLight,
                ),
              ),
              GestureDetector(
                onTap: isEnabled
                    ? () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Opening Beneficiary Directory...'),
                          ),
                        );
                      }
                    : null,
                child: Text(
                  'find_beneficiary'.tr(),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isEnabled ? AppColors.primary : AppColors.textLight,
                  ),
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
