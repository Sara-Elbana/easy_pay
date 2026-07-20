import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:easy_pay_app/core/widgets/custom_text_field.dart';
import 'package:easy_pay_app/core/widgets/selection_box.dart';
import 'package:flutter/material.dart';

class BeneficiaryFormFields extends StatefulWidget {
  final bool isBankBranchVisible;
  final bool isAmountContentVisible;
  final bool isEnabled;

  final TextEditingController nameController;
  final TextEditingController cardController;
  final TextEditingController? amountController;
  final TextEditingController? contentController;

  final ValueChanged<String> onNameChanged;
  final ValueChanged<String> onCardNumberChanged;
  final ValueChanged<String>? onAmountChanged;
  final ValueChanged<String>? onContentChanged;

  final String selectedBank;
  final String selectedBranch;
  final VoidCallback? onChooseBank;
  final VoidCallback? onChooseBranch;

  final bool isAmountExceeded;

  const BeneficiaryFormFields({
    super.key,
    required this.isBankBranchVisible,
    required this.isAmountContentVisible,
    this.isEnabled = true,
    required this.nameController,
    required this.cardController,
    this.amountController,
    this.contentController,
    required this.onNameChanged,
    required this.onCardNumberChanged,
    this.onAmountChanged,
    this.onContentChanged,
    this.selectedBank = '',
    this.selectedBranch = '',
    this.onChooseBank,
    this.onChooseBranch,
    this.isAmountExceeded = false,
  });

  @override
  State<BeneficiaryFormFields> createState() => _BeneficiaryFormFieldsState();
}

class _BeneficiaryFormFieldsState extends State<BeneficiaryFormFields> {
  String _amountInWords = '';

  @override
  void initState() {
    super.initState();
    if (widget.amountController != null) {
      widget.amountController!.addListener(_updateAmountWords);
    }
  }

  @override
  void dispose() {
    if (widget.amountController != null) {
      widget.amountController!.removeListener(_updateAmountWords);
    }
    super.dispose();
  }

  void _updateAmountWords() {
    if (widget.amountController == null) return;
    final text = widget.amountController!.text.trim();
    final cleanNumText = text.replaceAll(RegExp(r'[^0-9]'), '');
    final number = int.tryParse(cleanNumText);

    if (number == null || number == 0) {
      setState(() {
        _amountInWords = '';
      });
      return;
    }

    final words = _convertToWords(number);
    setState(() {
      _amountInWords = '$words dollar${number > 1 ? 's' : ''}';
    });
  }

  String _convertToWords(int number) {
    final units = [
      "", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine",
      "Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen",
      "Seventeen", "Eighteen", "Nineteen"
    ];
    final tens = [
      "", "", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety"
    ];

    String convert(int n) {
      if (n < 20) return units[n];
      if (n < 100) return '${tens[n ~/ 10]}${n % 10 != 0 ? ' ${units[n % 10]}' : ''}';
      if (n < 1000) return '${units[n ~/ 100]} Hundred${n % 100 != 0 ? ' ${convert(n % 100)}' : ''}';
      if (n < 1000000) return '${convert(n ~/ 1000)} Thousand${n % 1000 != 0 ? ' ${convert(n % 1000)}' : ''}';
      return '${convert(n ~/ 1000000)} Million${n % 1000000 != 0 ? ' ${convert(n % 1000000)}' : ''}';
    }

    return convert(number);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.isBankBranchVisible) ...[
          // Bank Selector
          Text(
            'choose_bank'.tr(),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.gray,
            ),
          ),
          SizedBox(height: context.scaleHeight(6)),
          SelectionBox(
            value: widget.selectedBank,
            placeholder: 'choose_bank'.tr(),
            isEnabled: widget.isEnabled,
            onTap: widget.onChooseBank ?? () {},
          ),
          SizedBox(height: context.scaleHeight(16)),

          // Branch Selector
          Text(
            'choose_branch'.tr(),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.gray,
            ),
          ),
          SizedBox(height: context.scaleHeight(6)),
          SelectionBox(
            value: widget.selectedBranch,
            placeholder: 'choose_branch'.tr(),
            isEnabled: widget.isEnabled && widget.selectedBank.isNotEmpty,
            onTap: widget.onChooseBranch ?? () {},
          ),
          SizedBox(height: context.scaleHeight(16)),
        ],

        // Name field
        Text(
          'name'.tr(),
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.gray,
          ),
        ),
        SizedBox(height: context.scaleHeight(6)),
        CustomTextField(
          controller: widget.nameController,
          hintText: 'name'.tr(),
          enabled: widget.isEnabled,
          onChanged: widget.onNameChanged,
        ),
        SizedBox(height: context.scaleHeight(16)),

        // Card number field
        Text(
          'card_number_label'.tr(),
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.gray,
          ),
        ),
        SizedBox(height: context.scaleHeight(6)),
        CustomTextField(
          controller: widget.cardController,
          hintText: 'card_number_label'.tr(),
          enabled: widget.isEnabled,
          onChanged: widget.onCardNumberChanged,
          keyboardType: TextInputType.number,
        ),

        if (widget.isAmountContentVisible) ...[
          SizedBox(height: context.scaleHeight(16)),
          // Amount field
          Text(
            'amount_label'.tr(),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.gray,
            ),
          ),
          SizedBox(height: context.scaleHeight(6)),
          CustomTextField(
            controller: widget.amountController!,
            hintText: 'amount_label'.tr(),
            enabled: widget.isEnabled,
            onChanged: widget.onAmountChanged,
            keyboardType: TextInputType.number,
          ),
          if (widget.isAmountExceeded) ...[
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                'amount_exceeds_balance'.tr(),
                style: const TextStyle(
                  color: AppColors.error,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
          if (_amountInWords.isNotEmpty) ...[
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                _amountInWords.toLowerCase(),
                style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],

          SizedBox(height: context.scaleHeight(16)),
          // Content field
          Text(
            'content_label'.tr(),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.gray,
            ),
          ),
          SizedBox(height: context.scaleHeight(6)),
          CustomTextField(
            controller: widget.contentController!,
            hintText: 'content_label'.tr(),
            enabled: widget.isEnabled,
            onChanged: widget.onContentChanged,
          ),
        ],
      ],
    );
  }
}
