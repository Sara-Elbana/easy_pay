import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/widgets/custom_text_field.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class BeneficiarySearchField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const BeneficiarySearchField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      hintText: 'search'.tr(),
      prefixIcon: const Icon(Icons.search, color: AppColors.textLight),
      onChanged: onChanged,
    );
  }
}
