import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:easy_pay_app/core/widgets/custom_button.dart';
import 'package:easy_pay_app/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/beneficiary.dart';

class DetailFieldsCard extends StatelessWidget {
  final Beneficiary beneficiary;
  final VoidCallback onConfirm;

  const DetailFieldsCard({
    super.key,
    required this.beneficiary,
    required this.onConfirm,
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
          if (beneficiary.type == 2) ...[
            // Bank
            Text(
              'choose_bank'.tr(),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.gray,
              ),
            ),
            SizedBox(height: context.scaleHeight(6)),
            CustomTextField(
              controller: TextEditingController(text: beneficiary.bank),
              hintText: '',
              enabled: false,
            ),
            SizedBox(height: context.scaleHeight(16)),

            // Branch
            Text(
              'choose_branch'.tr(),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.gray,
              ),
            ),
            SizedBox(height: context.scaleHeight(6)),
            CustomTextField(
              controller: TextEditingController(text: beneficiary.branch),
              hintText: '',
              enabled: false,
            ),
            SizedBox(height: context.scaleHeight(16)),
          ],

          // Transaction Name
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
            controller: TextEditingController(text: beneficiary.name),
            hintText: '',
            enabled: false,
          ),
          SizedBox(height: context.scaleHeight(16)),

          // Card number
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
            controller: TextEditingController(text: beneficiary.cardNumber),
            hintText: '',
            enabled: false,
          ),
          SizedBox(height: context.scaleHeight(32)),

          // Confirm/Select Button
          CustomButton(
            text: 'confirm_label'.tr(),
            onPressed: onConfirm,
          ),
        ],
      ),
    );
  }
}
