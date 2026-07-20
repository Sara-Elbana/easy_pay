import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:easy_pay_app/core/widgets/custom_button.dart';
import 'package:easy_pay_app/core/widgets/beneficiary_form_fields.dart';
import 'package:flutter/material.dart';

class AddBeneficiaryForm extends StatelessWidget {
  final int selectedType;
  final String name;
  final String cardNumber;
  final String selectedBank;
  final String selectedBranch;
  final bool isFormValid;
  final bool isLoading;
  final TextEditingController nameController;
  final TextEditingController cardController;
  final ValueChanged<String> onNameChanged;
  final ValueChanged<String> onCardNumberChanged;
  final VoidCallback onChooseBank;
  final VoidCallback onChooseBranch;
  final VoidCallback onSave;

  const AddBeneficiaryForm({
    super.key,
    required this.selectedType,
    required this.name,
    required this.cardNumber,
    required this.selectedBank,
    required this.selectedBranch,
    required this.isFormValid,
    required this.isLoading,
    required this.nameController,
    required this.cardController,
    required this.onNameChanged,
    required this.onCardNumberChanged,
    required this.onChooseBank,
    required this.onChooseBranch,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.scaleWidth(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Color(0x123629B7),
            offset: Offset(0, 4),
            blurRadius: 30,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BeneficiaryFormFields(
            isBankBranchVisible: selectedType == 2,
            isAmountContentVisible: false,
            isEnabled: !isLoading,
            nameController: nameController,
            cardController: cardController,
            onNameChanged: onNameChanged,
            onCardNumberChanged: onCardNumberChanged,
            selectedBank: selectedBank,
            selectedBranch: selectedBranch,
            onChooseBank: onChooseBank,
            onChooseBranch: onChooseBranch,
          ),
          SizedBox(height: context.scaleHeight(24)),
          // Submit Button
          CustomButton(
            text: 'save_to_directory'.tr(),
            isEnabled: isFormValid && !isLoading,
            isLoading: isLoading,
            onPressed: onSave,
          ),
        ],
      ),
    );
  }
}
