import 'package:easy_pay_app/core/widgets/account_dropdown.dart';
import 'package:easy_pay_app/features/withdraw/presentation/cubit/withdraw_cubit.dart';
import 'package:easy_pay_app/features/withdraw/presentation/cubit/withdraw_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WithdrawCardDropdown extends StatelessWidget {
  const WithdrawCardDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WithdrawCubit, WithdrawState>(
      buildWhen: (previous, current) =>
          previous.cards != current.cards ||
          previous.selectedCard != current.selectedCard,
      builder: (context, state) {
        return AccountDropdown(
          cards: state.cards,
          selectedCard: state.selectedCard,
          onChanged: (card) {
            context.read<WithdrawCubit>().selectCard(card);
          },
        );
      },
    );
  }
}
