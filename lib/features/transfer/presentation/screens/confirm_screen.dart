import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/routes/app_routes_name.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/widgets/custom_button.dart';
import 'package:easy_pay_app/features/transfer/presentation/widgets/confirm_transaction_info_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/transfer_cubit.dart';
import '../cubit/transfer_state.dart';
import '../widgets/otp_verification_widget.dart';

class ConfirmScreen extends StatelessWidget {
  final _otpController = TextEditingController();

  // Form controllers for editing
  final _nameController = TextEditingController();
  final _cardController = TextEditingController();
  final _feeController = TextEditingController();
  final _contentController = TextEditingController();
  final _amountController = TextEditingController();

  ConfirmScreen({super.key});

  void _onStateChanged(BuildContext context, TransferState state) {
    if (state.isSuccess) {
      Navigator.pushReplacementNamed(
        context,
        AppRoutesName.successTransferScreen,
        arguments: context.read<TransferCubit>(),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final cubit = ModalRoute.of(context)!.settings.arguments as TransferCubit;
    final theme = Theme.of(context);

    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: theme.scaffoldBackgroundColor,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: theme.iconTheme.color ?? AppColors.textDark,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'confirm_label'.tr(),
            style: TextStyle(
              color: theme.textTheme.titleLarge?.color ?? AppColors.textDark,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: BlocConsumer<TransferCubit, TransferState>(
          listener: _onStateChanged,
          builder: (context, state) {
            // Initialize input field controllers with original states
            if (_nameController.text.isEmpty && state.name.isNotEmpty) {
              _nameController.text = state.name;
            }
            if (_cardController.text.isEmpty && state.cardNumber.isNotEmpty) {
              _cardController.text = state.cardNumber;
            }
            if (_contentController.text.isEmpty && state.content.isNotEmpty) {
              _contentController.text = state.content;
            }
            if (_amountController.text.isEmpty && state.amount.isNotEmpty) {
              _amountController.text = state.amount;
            }

            // Calculate dynamic transaction fee: 0.1% (0.001 factor) of amount, minimum is 0.5
            final double amountVal = double.tryParse(state.amount.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0;
            double feeVal = amountVal * 0.001;
            if (feeVal < 0.5) {
              feeVal = 0.5;
            }
            final String feeStr = '${feeVal.toStringAsFixed(2).replaceAll(RegExp(r'\.00$'), '')}\$';
            _feeController.text = feeStr;

            // Verification satisfies if OTP is exactly '6789' or if biometric is verified
            final bool isVerified =
                (state.otpMode && state.otpCode == '6789') ||
                    (!state.otpMode && state.isBiometricVerified);

            return SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ConfirmTransactionInfoSection(
                      state: state,
                      cubit: cubit,
                      nameController: _nameController,
                      cardController: _cardController,
                      feeController: _feeController,
                      contentController: _contentController,
                      amountController: _amountController,
                    ),
                    const SizedBox(height: 24),

                    // Verification Mode Selector (Segmented control)
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.gray100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(4),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => cubit.toggleVerificationMode(true),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: state.otpMode
                                      ? Colors.white
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                alignment: Alignment.center,
                                child: Text(
                                  'OTP Code',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: state.otpMode
                                        ? AppColors.primary
                                        : AppColors.textLight,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => cubit.toggleVerificationMode(false),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: !state.otpMode
                                      ? Colors.white
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                alignment: Alignment.center,
                                child: Text(
                                  'Biometrics',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: !state.otpMode
                                        ? AppColors.primary
                                        : AppColors.textLight,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),
                    OTPVerificationWidget(
                      otpMode: state.otpMode,
                      otpController: _otpController,
                      otpRequested: state.otpRequested,
                      isBiometricVerified: state.isBiometricVerified,
                      isLoading: state.isLoading,
                      onGetOtpPressed: () {
                        cubit.requestOtpCode();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('OTP is sent'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                      onBiometricPressed: cubit.verifyBiometric,
                      onOtpChanged: cubit.updateOtpCode,
                    ),
                    const SizedBox(height: 36),
                    CustomButton(
                      text: 'confirm_label'.tr(),
                      isEnabled: isVerified && !state.isLoading,
                      isLoading: state.isLoading,
                      onPressed: cubit.submitTransfer,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
