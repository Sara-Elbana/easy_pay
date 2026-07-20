import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/routes/app_routes_name.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/widgets/custom_app_bar.dart';
import 'package:easy_pay_app/core/widgets/custom_button.dart';
import 'package:easy_pay_app/core/widgets/custom_checkbox.dart';
import 'package:easy_pay_app/features/transfer/presentation/widgets/choose_beneficiary_section.dart';
import 'package:easy_pay_app/features/beneficiary/presentation/widgets/add_beneficiary_type_selector.dart';
import 'package:flutter/material.dart';
import 'package:easy_pay_app/features/beneficiary/domain/entities/beneficiary.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/transfer_cubit.dart';
import '../cubit/transfer_state.dart';
import '../utils/transfer_controllers_manager.dart';
import '../widgets/account_dropdown.dart';
import 'package:easy_pay_app/core/widgets/beneficiary_form_fields.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:easy_pay_app/core/widgets/custom_selection_dialog.dart';

class TransferScreen extends StatelessWidget {
  final _controllersManager = TransferControllersManager();

  TransferScreen({super.key});

  void _onStateChanged(BuildContext context, TransferState state) {
    _controllersManager.syncState(state);
  }

  void _showBankSelection(BuildContext parentContext, TransferCubit cubit, TransferState state) {
    CustomSelectionDialog.show<TransferCubit, TransferState>(
      context: parentContext,
      cubit: cubit,
      title: 'choose_beneficiary_bank'.tr(),
      selectedValue: state.selectedBank,
      itemsProvider: (s) => s.filteredBanks,
      searchQueryProvider: (s) => s.bankSearchQuery,
      onSearchChanged: cubit.updateBankSearch,
      onSelected: cubit.selectBank,
      onDismissed: cubit.resetSearchQueries,
    );
  }

  void _showBranchSelection(BuildContext parentContext, TransferCubit cubit, TransferState state) {
    CustomSelectionDialog.show<TransferCubit, TransferState>(
      context: parentContext,
      cubit: cubit,
      title: 'choose_beneficiary_branch'.tr(),
      selectedValue: state.selectedBranch,
      itemsProvider: (s) => s.filteredBranches,
      searchQueryProvider: (s) => s.branchSearchQuery,
      onSearchChanged: cubit.updateBranchSearch,
      onSelected: cubit.selectBranch,
      onDismissed: cubit.resetSearchQueries,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TransferCubit>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: 'transfer'.tr(),
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
          final bool isBeneficiaryEnabled =
              isTransactionTypeEnabled && state.selectedTransactionType != null;
          final bool isFormFieldsEnabled = isBeneficiaryEnabled &&
              (state.selectedBeneficiary != null || state.isManualBeneficiary);

          return SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: context.padHigh,
                vertical: context.scaleHeight(16),
              ),
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
                  SizedBox(height: context.scaleHeight(24)),
                  Text(
                    'choose_transaction'.tr(),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textLight,
                    ),
                  ),
                  const SizedBox(height: 12),
                  AddBeneficiaryTypeSelector(
                    selectedType: state.selectedTransactionType,
                    isEnabled: isTransactionTypeEnabled,
                    onTypeSelected: cubit.selectTransactionType,
                  ),
                  SizedBox(height: context.scaleHeight(24)),
                  ChooseBeneficiarySection(
                    beneficiaries: state.filteredBeneficiaries,
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
                    onFindBeneficiary: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutesName.beneficiaryDirectoryScreen,
                      ).then((result) {
                        cubit.loadTransferData();
                        if (result is Beneficiary) {
                          cubit.selectBeneficiary(result);
                        }
                      });
                    },
                  ),
                  BeneficiaryFormFields(
                    isBankBranchVisible: state.selectedTransactionType == 2,
                    isAmountContentVisible: true,
                    isEnabled: isFormFieldsEnabled,
                    nameController: _controllersManager.nameController,
                    cardController: _controllersManager.cardController,
                    amountController: _controllersManager.amountController,
                    contentController: _controllersManager.contentController,
                    onNameChanged: cubit.updateName,
                    onCardNumberChanged: cubit.updateCardNumber,
                    onAmountChanged: cubit.updateAmount,
                    onContentChanged: cubit.updateContent,
                    selectedBank: state.selectedBank,
                    selectedBranch: state.selectedBranch,
                    onChooseBank: () => _showBankSelection(context, cubit, state),
                    onChooseBranch: () => _showBranchSelection(context, cubit, state),
                    isAmountExceeded: state.isAmountExceeded,
                  ),
                   SizedBox(height: context.scaleHeight(16)),
                  CustomCheckbox(
                    value: state.saveBeneficiary,
                    label: 'save_to_directory'.tr(),
                    isEnabled: isFormFieldsEnabled,
                    onChanged: (val) {
                      cubit.toggleSaveBeneficiary(val ?? false);
                    },
                  ),
                   SizedBox(height: context.scaleHeight(32)),
                  CustomButton(
                    text: 'confirm_label'.tr(),
                    isEnabled: state.isFormValid &&
                        state.saveBeneficiary &&
                        !state.isLoading,
                    isLoading: state.isLoading,
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutesName.confirmScreen,
                        arguments: cubit,
                      );
                    },
                  ),
                   SizedBox(height: context.scaleHeight(24)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
