import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/routes/app_routes_name.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:easy_pay_app/core/widgets/custom_button.dart';
import 'package:easy_pay_app/core/widgets/custom_error_widget.dart';
import 'package:easy_pay_app/core/widgets/custom_loading_widget.dart';
import 'package:easy_pay_app/features/account_and_card/presentation/cubit/account_cubit.dart';
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
        if (state is BaseLoading) {
          return const CustomLoadingWidget();
        } else if (state is BaseSuccess) {
          final cards = (state as BaseSuccess).data;
          if (cards.isEmpty) {
            return Center(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: context.scaleWidth(24)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("no_cards_found".tr()),
                    SizedBox(height: context.scaleHeight(40)),
                    CustomButton(
                      text: 'add_card'.tr(),
                      onPressed: () async {
                        await Navigator.pushNamed(
                          context,
                          AppRoutesName.addCardScreen,
                          arguments: context.read<CardCubit>(),
                        );
                        if (context.mounted) {
                          context.read<AccountCubit>().loadAccounts();
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          }
          return CardTabView(cards: cards);
        } else if (state is BaseError) {

          return CustomErrorWidget(
            message: (state as BaseError).message,
            onRetry: () {
              context.read<CardCubit>().loadCards();
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
