import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/di/service_locator.dart';
import 'package:easy_pay_app/core/routes/app_routes_name.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/theme/app_text_styles.dart';
import 'package:easy_pay_app/features/auth/domain/use_cases/sign_out_usecase.dart';
import 'package:flutter/material.dart';

class SignOutDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const SignOutDialog({super.key, required this.onConfirm});

  static Future<void> show(BuildContext parentContext) {
    final signOutUseCase = getIt<SignOutUseCase>();

    return showDialog(
      context: parentContext,
      builder: (dialogContext) => SignOutDialog(
        onConfirm: () async {
          Navigator.of(dialogContext).pop();
          Navigator.of(parentContext).pushNamedAndRemoveUntil(
            AppRoutesName.signInScreen,
            (route) => false,
          );
          try {
            await signOutUseCase();
          } catch (_) {}
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(
        'sign_out'.tr(),
        style: AppTextStyles.titleMedium.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        'are_you_sure_sign_out'.tr(),
        style: AppTextStyles.bodyMedium,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'no'.tr(),
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.gray500,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.error,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: onConfirm,
          child: Text(
            'yes'.tr(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
