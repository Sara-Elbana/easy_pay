import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/core.dart';
import 'package:easy_pay_app/core/widgets/custom_app_bar.dart';
import 'package:easy_pay_app/core/widgets/custom_error_widget.dart';
import 'package:easy_pay_app/core/widgets/custom_loading_widget.dart';
import 'package:easy_pay_app/features/account_and_card/domain/entities/card_entity.dart';
import 'package:easy_pay_app/features/account_and_card/presentation/cubit/card_cubit.dart';
import 'package:easy_pay_app/features/account_and_card/presentation/cubit/card_state.dart';
import 'package:easy_pay_app/features/account_and_card/presentation/widgets/card_info_row.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardDetailsScreen extends StatelessWidget {
  final CardEntity? card;

  const CardDetailsScreen({super.key, this.card});

  @override
  Widget build(BuildContext context) {
    final CardEntity? currentCard =
        card ?? (ModalRoute.of(context)?.settings.arguments as CardEntity?);

    if (currentCard == null) {
      return Scaffold(
        backgroundColor: AppColors.white,
        appBar: CustomAppBar(
          title: 'Card'.tr(),
        ),
        body: const Center(child: Text('No card data found')),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Card'.tr(),
      ),
      body: BlocConsumer<CardCubit, CardState>(listener: (context, state) {
        if (state is CardSuccess) {
          Navigator.pop(context);
        }
      }, builder: (context, state) {
        if (state is CardLoading) {
          return const CustomLoadingWidget();
        } else if (state is CardError) {
          return CustomErrorWidget(
            message: state.message,
          );
        }
        return Padding(
          padding: EdgeInsets.all(context.scaleWidth(8)),
          child: Column(
            children: [
              CardInfoRow(label: 'Name', value: currentCard.cardHolderName),
              CardInfoRow(
                  label: 'Card number', value: currentCard.maskedCardNumber),
              CardInfoRow(
                  label: 'Valid from', value: currentCard.expirationDate),
              CardInfoRow(
                  label: 'Good thru', value: currentCard.expirationDate),
              CardInfoRow(
                  label: 'Available balance',
                  value: '\$${currentCard.bankAccount.balance}'),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(bottom: context.scaleHeight(40.0)),
                child: TextButton(
                  onPressed: () {
                    context.read<CardCubit>().removeCard(currentCard.id);
                  },
                  child: Text(
                    'delete_card'.tr(),
                    style: AppTextStyles.bodyLargeSemiBold.copyWith(
                      fontSize: context.scaleWidth(
                          AppTextStyles.bodyLargeSemiBold.fontSize ?? 16),
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
