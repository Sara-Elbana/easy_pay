import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/routes/app_routes_name.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/widgets/custom_button.dart';
import 'package:easy_pay_app/core/widgets/custom_checkbox.dart';
import 'package:easy_pay_app/features/transfer/presentation/widgets/choose_beneficiary_section.dart';
import 'package:easy_pay_app/features/transfer/presentation/widgets/choose_transaction_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/transfer_cubit.dart';
import '../cubit/transfer_state.dart';
import '../utils/transfer_controllers_manager.dart';
import '../widgets/account_dropdown.dart';
import '../widgets/transfer_form_section.dart';

class TransferScreen extends StatelessWidget {
  final _controllersManager = TransferControllersManager();

  TransferScreen({super.key});

  void _onStateChanged(BuildContext context, TransferState state) {
    _controllersManager.syncState(state);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = context.read<TransferCubit>();

    return Scaffold(
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
          'transfer'.tr(),
          style: TextStyle(
            color: theme.textTheme.titleLarge?.color ?? AppColors.textDark,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocConsumer<TransferCubit, TransferState>(
        listener: _onStateChanged,
        builder: (context, state) {
          if (state.isLoading && state.cards.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            );
          }

          final bool isTransactionTypeEnabled = state.selectedCard != null;
          final bool isBeneficiaryEnabled = isTransactionTypeEnabled && state.selectedTransactionType != null;
          final bool isFormFieldsEnabled = isBeneficiaryEnabled && (state.selectedBeneficiary != null || state.isManualBeneficiary);

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AccountDropdown(
                    cards: state.cards,
                    selectedCard: state.selectedCard,
                    onChanged: (card) {
                      cubit.selectCard(card);
                    },
                  ),
                  const SizedBox(height: 24),
                  ChooseTransactionSection(
                    selectedTransactionType: state.selectedTransactionType,
                    isEnabled: isTransactionTypeEnabled,
                    onTransactionTypeSelected: cubit.selectTransactionType,
                  ),
                  const SizedBox(height: 24),
                  ChooseBeneficiarySection(
                    beneficiaries: state.beneficiaries,
                    selectedBeneficiary: state.selectedBeneficiary,
                    isManualBeneficiary: state.isManualBeneficiary,
                    isEnabled: isBeneficiaryEnabled,
                    onSelectManual: () {
                      cubit.selectManualBeneficiary();
                      _controllersManager.nameController.clear();
                      _controllersManager.cardController.clear();
                      _controllersManager.amountController.clear();
                      _controllersManager.contentController.clear();
                    },
                    onSelectBeneficiary: cubit.selectBeneficiary,
                  ),
                  const SizedBox(height: 24),
                  TransferFormSection(
                    nameController: _controllersManager.nameController,
                    cardController: _controllersManager.cardController,
                    amountController: _controllersManager.amountController,
                    contentController: _controllersManager.contentController,
                    onNameChanged: cubit.updateName,
                    onCardChanged: cubit.updateCardNumber,
                    onAmountChanged: cubit.updateAmount,
                    onContentChanged: cubit.updateContent,
                    isEnabled: isFormFieldsEnabled,
                    isAmountExceeded: state.isAmountExceeded,
                  ),
                  const SizedBox(height: 16),
                  CustomCheckbox(
                    value: state.saveBeneficiary,
                    label: 'save_to_directory'.tr(),
                    isEnabled: isFormFieldsEnabled,
                    onChanged: (val) {
                      cubit.toggleSaveBeneficiary(val ?? false);
                    },
                  ),
                  const SizedBox(height: 32),
                  CustomButton(
                    text: 'confirm_label'.tr(),
                    isEnabled: state.isFormValid && !state.isLoading,
                    isLoading: state.isLoading,
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutesName.confirmScreen,
                        arguments: cubit,
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
