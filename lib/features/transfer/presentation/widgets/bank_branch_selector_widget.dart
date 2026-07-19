import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/features/transfer/presentation/cubit/transfer_cubit.dart';
import 'package:easy_pay_app/features/transfer/presentation/cubit/transfer_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_pay_app/core/widgets/custom_selection_dialog.dart';

class BankBranchSelectorWidget extends StatelessWidget {
  final String label;
  final String value;
  final String placeholder;
  final bool isEnabled;
  final List<String> Function(TransferState) itemsProvider;
  final String Function(TransferState) searchQueryProvider;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<String> onSelected;
  final VoidCallback onDismissed;

  const BankBranchSelectorWidget({
    super.key,
    required this.label,
    required this.value,
    required this.placeholder,
    required this.isEnabled,
    required this.itemsProvider,
    required this.searchQueryProvider,
    required this.onSearchChanged,
    required this.onSelected,
    required this.onDismissed,
  });

  void _showSelectionDialog(BuildContext parentContext) {
    final cubit = parentContext.read<TransferCubit>();

    showDialog(
      context: parentContext,
      builder: (dialogContext) {
        return BlocProvider.value(
          value: cubit,
          child: CustomSelectionDialog<TransferCubit, TransferState>(
            title: label,
            selectedValue: value,
            itemsProvider: itemsProvider,
            searchQueryProvider: searchQueryProvider,
            onSearchChanged: onSearchChanged,
            onSelected: onSelected,
          ),
        );
      },
    ).then((_) => onDismissed());
  }

  @override
  Widget build(BuildContext context) {
    final bool hasValue = value.trim().isNotEmpty;

    return GestureDetector(
      onTap: isEnabled ? () => _showSelectionDialog(context) : null,
      child: InputDecorator(
        isEmpty: !hasValue,
        decoration: InputDecoration(
          filled: true,
          fillColor: isEnabled
              ? Colors.white
              : AppColors.gray100.withAlpha(50),
          enabled: isEnabled,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide:
                const BorderSide(color: AppColors.inputBorder, width: 1.5),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide:
                BorderSide(color: AppColors.inputBorder.withAlpha(50), width: 1.5),
          ),
          suffixIcon: Icon(
            hasValue ? Icons.chevron_right : Icons.keyboard_arrow_down,
            color: isEnabled ? AppColors.textLight : AppColors.gray400,
            size: 20,
          ),
        ),
        child: Text(
          hasValue ? value : placeholder,
          style: TextStyle(
            fontSize: 16,
            fontWeight: hasValue ? FontWeight.w500 : FontWeight.w400,
            color: hasValue
                ? AppColors.textDark
                : (isEnabled
                    ? AppColors.textLight
                    : AppColors.textLight.withAlpha(50)),
          ),
        ),
      ),
    );
  }
}
