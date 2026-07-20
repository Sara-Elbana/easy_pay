import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/widgets/custom_text_field.dart';
import 'package:easy_pay_app/features/transfer/presentation/widgets/account_dropdown.dart';
import 'package:easy_pay_app/core/widgets/selection_box.dart';
import 'package:easy_pay_app/core/widgets/custom_selection_dialog.dart';
import 'package:flutter/material.dart';
import '../cubit/transfer_cubit.dart';
import '../cubit/transfer_state.dart';

class ConfirmTransactionInfoSection extends StatelessWidget {
  final TransferState state;
  final TransferCubit cubit;
  final TextEditingController nameController;
  final TextEditingController cardController;
  final TextEditingController feeController;
  final TextEditingController contentController;
  final TextEditingController amountController;

  const ConfirmTransactionInfoSection({
    super.key,
    required this.state,
    required this.cubit,
    required this.nameController,
    required this.cardController,
    required this.feeController,
    required this.contentController,
    required this.amountController,
  });

  void _showBankSelection(BuildContext parentContext) {
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

  void _showBranchSelection(BuildContext parentContext) {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'confirm_transaction_information'.tr(),
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: AppColors.textLight,
          ),
        ),
        const SizedBox(height: 16),

        // From
        Text('from'.tr(), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.textLight)),
        const SizedBox(height: 6),
        AccountDropdown(
          cards: state.cards,
          selectedCard: state.selectedCard,
          onChanged: (card) {
            cubit.selectCard(card);
          },
        ),
        const SizedBox(height: 12),

        if (state.selectedTransactionType == 2) ...[
          // Bank
          Text('choose_bank'.tr(), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.textLight)),
          const SizedBox(height: 6),
          SelectionBox(
            value: state.selectedBank,
            placeholder: 'choose_bank'.tr(),
            isEnabled: true,
            onTap: () => _showBankSelection(context),
          ),
          const SizedBox(height: 12),

          // Branch
          Text('choose_branch'.tr(), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.textLight)),
          const SizedBox(height: 6),
          SelectionBox(
            value: state.selectedBranch,
            placeholder: 'choose_branch'.tr(),
            isEnabled: state.selectedBank.isNotEmpty,
            onTap: () => _showBranchSelection(context),
          ),
          const SizedBox(height: 12),
        ],

        // To Name
        Text('to'.tr(), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.textLight)),
        const SizedBox(height: 6),
        CustomTextField(
          controller: nameController,
          hintText: 'name'.tr(),
          onChanged: cubit.updateName,
        ),
        const SizedBox(height: 12),

        // Card Number
        Text('card_number_label'.tr(), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.textLight)),
        const SizedBox(height: 6),
        CustomTextField(
          controller: cardController,
          hintText: 'card_number_label'.tr(),
          keyboardType: TextInputType.number,
          onChanged: cubit.updateCardNumber,
        ),
        const SizedBox(height: 12),

        // Fee (read-only dynamically updated)
        Text('transaction_fee_label'.tr(), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.textLight)),
        const SizedBox(height: 6),
        CustomTextField(
          controller: feeController,
          hintText: 'transaction_fee_hint'.tr(),
          enabled: false,
        ),
        const SizedBox(height: 12),

        // Content
        Text('content_label'.tr(), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.textLight)),
        const SizedBox(height: 6),
        CustomTextField(
          controller: contentController,
          hintText: 'content_label'.tr(),
          onChanged: cubit.updateContent,
        ),
        const SizedBox(height: 12),

        // Amount
        Text('amount_label'.tr(), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.textLight)),
        const SizedBox(height: 6),
        CustomTextField(
          controller: amountController,
          hintText: 'amount_label'.tr(),
          keyboardType: TextInputType.number,
          onChanged: cubit.updateAmount,
        ),
      ],
    );
  }
}
