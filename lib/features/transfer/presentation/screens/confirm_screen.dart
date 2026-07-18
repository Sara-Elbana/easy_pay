import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/routes/app_routes_name.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:easy_pay_app/core/widgets/custom_app_bar.dart';
import 'package:easy_pay_app/core/widgets/custom_button.dart';
import 'package:easy_pay_app/features/transfer/presentation/widgets/confirm_transaction_info_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/transfer_cubit.dart';
import '../cubit/transfer_state.dart';
import '../widgets/otp_verification_widget.dart';

class ConfirmScreen extends StatelessWidget {
  final _otpController = TextEditingController();

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
        appBar: CustomAppBar(
          title: 'confirm_label'.tr(),
        ),
        body: BlocConsumer<TransferCubit, TransferState>(
          listener: _onStateChanged,
          builder: (context, state) {
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

            final String feeStr =
                '${state.fee.toStringAsFixed(2).replaceAll(RegExp(r'\.00$'), '')}\$';
            _feeController.text = feeStr;

            final bool isVerified =
                (state.otpMode && state.otpCode == '6789') ||
                    (!state.otpMode && state.isBiometricVerified);

            return SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(context.padHigh),
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
                    SizedBox(height: context.scaleHeight(24)),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.gray100,
                        borderRadius:
                            BorderRadius.circular(context.scaleWidth(10)),
                      ),
                      padding: EdgeInsets.all(context.scaleWidth(4)),
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
                                  borderRadius: BorderRadius.circular(
                                      context.scaleWidth(8)),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                alignment: Alignment.center,
                                child: Text(
                                  'otp_code_label'.tr(),
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
                                  borderRadius: BorderRadius.circular(
                                      context.scaleWidth(8)),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                alignment: Alignment.center,
                                child: Text(
                                  'biometrics_label'.tr(),
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
                    SizedBox(height: context.scaleHeight(24)),
                    OTPVerificationWidget(
                      otpMode: state.otpMode,
                      otpController: _otpController,
                      otpRequested: state.otpRequested,
                      isBiometricVerified: state.isBiometricVerified,
                      isLoading: state.isLoading,
                      onGetOtpPressed: () {
                        cubit.requestOtpCode();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('otp_sent_success'.tr()),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                      onBiometricPressed: cubit.verifyBiometric,
                      onOtpChanged: cubit.updateOtpCode,
                    ),
                    SizedBox(height: context.scaleHeight(36)),
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
