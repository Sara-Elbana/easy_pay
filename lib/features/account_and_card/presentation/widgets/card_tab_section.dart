import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/core.dart';
import 'package:easy_pay_app/features/account_and_card/presentation/cubit/card_cubit.dart';
import 'package:easy_pay_app/features/account_and_card/presentation/cubit/card_state.dart';
import 'package:easy_pay_app/features/account_and_card/presentation/widgets/card_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardTabSection extends StatelessWidget {
  const CardTabSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardCubit, CardState>(
      builder: (context, state) {
        if (state is CardLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        } else if (state is CardSuccess) {
          if (state.cards.isEmpty) {
            return Center(child: Text("no_cards_found".tr()));
          }
          return CardTabView(cards: state.cards);
        } else if (state is CardError) {
          return Center(
            child: Text(
              state.message,
              style: AppTextStyles.bodyMediumRed,
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}