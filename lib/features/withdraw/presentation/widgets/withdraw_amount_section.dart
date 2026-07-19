import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:easy_pay_app/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/withdraw_cubit.dart';
import '../cubit/withdraw_state.dart';
import 'amount_selector_grid.dart';

class WithdrawAmountSection extends StatefulWidget {
  const WithdrawAmountSection({super.key});

  @override
  State<WithdrawAmountSection> createState() => _WithdrawAmountSectionState();
}

class _WithdrawAmountSectionState extends State<WithdrawAmountSection> {
  late final TextEditingController _customAmountController;

  @override
  void initState() {
    super.initState();
    final initialVal = context.read<WithdrawCubit>().state.customAmount;
    _customAmountController = TextEditingController(text: initialVal);
    _customAmountController.addListener(_onCustomAmountChanged);
  }

  @override
  void dispose() {
    _customAmountController.removeListener(_onCustomAmountChanged);
    _customAmountController.dispose();
    super.dispose();
  }

  void _onCustomAmountChanged() {
    context.read<WithdrawCubit>().updateCustomAmount(_customAmountController.text);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WithdrawCubit, WithdrawState>(
      listenWhen: (previous, current) => previous.customAmount != current.customAmount,
      listener: (context, state) {
        if (state.customAmount != _customAmountController.text) {
          _customAmountController.value = TextEditingValue(
            text: state.customAmount,
            selection: TextSelection.collapsed(offset: state.customAmount.length),
          );
        }
      },
      buildWhen: (previous, current) =>
          previous.isAmountEnabled != current.isAmountEnabled ||
          previous.isOtherSelected != current.isOtherSelected ||
          previous.selectedAmount != current.selectedAmount,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'choose_amount'.tr(),
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: context.scaleWidth(16),
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
            SizedBox(height: context.scaleHeight(12)),
            if (state.isOtherSelected)
              CustomTextField(
                hintText: 'amount_label'.tr(),
                controller: _customAmountController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                enabled: state.isAmountEnabled,
              )
            else
              AmountSelectorGrid(
                selectedAmount: state.selectedAmount,
                isOtherSelected: state.isOtherSelected,
                isEnabled: state.isAmountEnabled,
                onAmountSelected: (amt) {
                  context.read<WithdrawCubit>().selectAmount(amt);
                },
                onOtherSelected: () {
                  context.read<WithdrawCubit>().selectOther();
                },
              ),
          ],
        );
      },
    );
  }
}
