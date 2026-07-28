import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/core.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';

class ChatInputField extends StatelessWidget {
  final TextEditingController controller;
  final bool isLoading;
  final VoidCallback onSendPressed;
  final ValueChanged<String>? onChanged;

  const ChatInputField({
    super.key,
    required this.controller,
    required this.isLoading,
    required this.onSendPressed,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.scaleWidth(24),
        vertical: context.scaleHeight(12),
      ),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: context.scaleWidth(8),
                vertical: context.scaleHeight(4),
              ),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.gray, width: 1),
                borderRadius: BorderRadius.circular(context.scaleWidth(20)),
              ),
              child: TextField(
                controller: controller,
                onChanged: onChanged,
                decoration: InputDecoration(
                  hintText: 'type_something'.tr(),
                  hintStyle: AppTextStyles.labelLarge.copyWith(
                    fontSize: context.scaleWidth(
                        AppTextStyles.labelLarge.fontSize ?? 14),
                    color: AppColors.lightGray,
                    fontFamily: 'Poppins',
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          SizedBox(width: context.scaleWidth(12)),
          GestureDetector(
            onTap: isLoading ? null : onSendPressed,
            child: Container(
              width: context.scaleWidth(44),
              height: context.scaleHeight(44),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(context.scaleWidth(22)),
              ),
              child: isLoading
                  ? const Padding(
                padding: EdgeInsets.all(10.0),
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
                  : Icon(
                Icons.arrow_forward_outlined,
                color: Colors.white,
                size: context.scaleWidth(22),
              ),
            ),
          ),
        ],
      ),
    );
  }
}