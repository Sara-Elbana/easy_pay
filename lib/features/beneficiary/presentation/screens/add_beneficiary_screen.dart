import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:easy_pay_app/core/widgets/custom_app_bar.dart';
import 'package:easy_pay_app/core/widgets/custom_selection_dialog.dart';
import 'package:flutter/material.dart';
import 'package:easy_pay_app/core/di/service_locator.dart';
import 'package:easy_pay_app/core/services/media_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/beneficiary_cubit.dart';
import '../cubit/beneficiary_state.dart';
import '../widgets/add_beneficiary_avatar.dart';
import '../widgets/add_beneficiary_type_selector.dart';
import '../widgets/add_beneficiary_form.dart';

class AddBeneficiaryScreen extends StatelessWidget {
  const AddBeneficiaryScreen({super.key});

  void _onStateChanged(BuildContext context, BeneficiaryState state) {
    if (state.isSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${'save_to_directory'.tr()} successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    }
    if (state.errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.errorMessage!),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showBankSelection(BuildContext parentContext, BeneficiaryCubit cubit, BeneficiaryState state) {
    CustomSelectionDialog.show<BeneficiaryCubit, BeneficiaryState>(
      context: parentContext,
      cubit: cubit,
      title: 'choose_bank'.tr(),
      selectedValue: state.selectedBank,
      itemsProvider: (s) => s.filteredBanks,
      searchQueryProvider: (s) => s.bankSearchQuery,
      onSearchChanged: cubit.updateBankSearch,
      onSelected: cubit.selectBank,
      onDismissed: cubit.resetSearchQueries,
    );
  }

  void _showBranchSelection(BuildContext parentContext, BeneficiaryCubit cubit, BeneficiaryState state) {
    CustomSelectionDialog.show<BeneficiaryCubit, BeneficiaryState>(
      context: parentContext,
      cubit: cubit,
      title: 'choose_branch'.tr(),
      selectedValue: state.selectedBranch,
      itemsProvider: (s) => s.filteredBranches,
      searchQueryProvider: (s) => s.branchSearchQuery,
      onSearchChanged: cubit.updateBranchSearch,
      onSelected: cubit.selectBranch,
      onDismissed: cubit.resetSearchQueries,
    );
  }

  Future<void> _pickImage(BuildContext context, BeneficiaryCubit cubit) async {
    final path = await getIt<MediaService>().pickImage(context);
    if (path != null) {
      cubit.updateAvatarUrl(path);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BeneficiaryCubit>();
    final nameController = TextEditingController();
    final cardController = TextEditingController();

    if (cubit.state.name.isNotEmpty) {
      nameController.text = cubit.state.name;
    }
    if (cubit.state.cardNumber.isNotEmpty) {
      cardController.text = cubit.state.cardNumber;
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: 'add_card'.tr(),
      ),
      body: BlocConsumer<BeneficiaryCubit, BeneficiaryState>(
        listener: _onStateChanged,
        builder: (context, state) {
          nameController.text = state.name;
          nameController.selection = TextSelection.collapsed(offset: state.name.length);
          cardController.text = state.cardNumber;
          cardController.selection = TextSelection.collapsed(offset: state.cardNumber.length);

          return SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: context.padHigh,
                vertical: context.scaleHeight(16),
              ),
              child: Column(
                children: [
                  AddBeneficiaryAvatar(
                    avatarUrl: state.avatarUrl,
                    name: state.name,
                    onPickImage: () => _pickImage(context, cubit),
                  ),
                  SizedBox(height: context.scaleHeight(24)),
                  AddBeneficiaryTypeSelector(
                    selectedType: state.selectedType,
                    onTypeSelected: cubit.selectType,
                  ),
                  SizedBox(height: context.scaleHeight(24)),
                  AddBeneficiaryForm(
                    selectedType: state.selectedType,
                    name: state.name,
                    cardNumber: state.cardNumber,
                    selectedBank: state.selectedBank,
                    selectedBranch: state.selectedBranch,
                    isFormValid: state.isFormValid,
                    isLoading: state.isLoading,
                    nameController: nameController,
                    cardController: cardController,
                    onNameChanged: cubit.updateName,
                    onCardNumberChanged: cubit.updateCardNumber,
                    onChooseBank: () => _showBankSelection(context, cubit, state),
                    onChooseBranch: () => _showBranchSelection(context, cubit, state),
                    onSave: () => cubit.saveBeneficiary(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
