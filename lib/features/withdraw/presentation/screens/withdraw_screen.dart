import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/di/service_locator.dart';
import 'package:easy_pay_app/core/routes/app_routes_name.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/widgets/custom_app_bar.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/withdraw_cubit.dart';
import '../cubit/withdraw_state.dart';
import '../widgets/withdraw_illustration.dart';
import '../widgets/withdraw_card_dropdown.dart';
import '../widgets/withdraw_phone_field.dart';
import '../widgets/withdraw_amount_section.dart';
import '../widgets/withdraw_verify_button.dart';

class WithdrawScreen extends StatelessWidget {
  const WithdrawScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WithdrawCubit>(
      create: (_) => getIt<WithdrawCubit>(),
      child: const WithdrawView(),
    );
  }
}

class WithdrawView extends StatelessWidget {
  const WithdrawView({super.key});

  void _showFallbackDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.scaleWidth(15)),
        ),
        title: Text(
          'biometric_verification'.tr(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(
          '$message\n\n${'biometric_fallback_msg'.tr()}',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<WithdrawCubit>().clearError();
            },
            child: Text(
              'cancel'.tr(),
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<WithdrawCubit>().forceSuccess();
            },
            child: Text(
              'proceed'.tr(),
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WithdrawCubit, WithdrawState>(
      listenWhen: (previous, current) =>
          previous.isSuccess != current.isSuccess ||
          previous.errorMessage != current.errorMessage,
      listener: (context, state) {
        if (state.isSuccess) {
          Navigator.pushReplacementNamed(context, AppRoutesName.withdrawSuccessScreen);
        } else if (state.errorMessage != null) {
          final err = state.errorMessage!;
          // If biometric error, show fallback dialog
          if (err.toLowerCase().contains('biometric') ||
              err.toLowerCase().contains('not supported') ||
              err.toLowerCase().contains('not available') ||
              err.toLowerCase().contains('enrolled')) {
            _showFallbackDialog(context, err);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(err),
                backgroundColor: AppColors.error,
              ),
            );
            context.read<WithdrawCubit>().clearError();
          }
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: CustomAppBar(
          title: "withdraw".tr(),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: context.scaleWidth(24)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: context.scaleHeight(8)),
                      const WithdrawIllustration(),
                      SizedBox(height: context.scaleHeight(32)),
                      const WithdrawCardDropdown(),
                      SizedBox(height: context.scaleHeight(20)),
                      const WithdrawPhoneField(),
                      SizedBox(height: context.scaleHeight(24)),
                      const WithdrawAmountSection(),
                      SizedBox(height: context.scaleHeight(24)),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(context.scaleWidth(24)),
                child: const WithdrawVerifyButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
