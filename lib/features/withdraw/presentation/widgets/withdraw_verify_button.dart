import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/di/service_locator.dart';
import 'package:easy_pay_app/core/services/biometric_service.dart';
import 'package:easy_pay_app/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/withdraw_cubit.dart';
import '../cubit/withdraw_state.dart';

class WithdrawVerifyButton extends StatelessWidget {
  const WithdrawVerifyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WithdrawCubit, WithdrawState>(
      buildWhen: (previous, current) =>
          previous.isFormValid != current.isFormValid ||
          previous.isLoading != current.isLoading,
      builder: (context, state) {
        return CustomButton(
          text: 'verify'.tr(),
          isEnabled: state.isFormValid,
          isLoading: state.isLoading,
          onPressed: () {
            final biometricService = getIt<BiometricService>();
            context.read<WithdrawCubit>().performWithdraw(biometricService);
          },
        );
      },
    );
  }
}
