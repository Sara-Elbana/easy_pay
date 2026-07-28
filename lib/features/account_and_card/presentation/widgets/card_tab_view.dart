import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/constants/app_assets.dart';
import 'package:easy_pay_app/core/core.dart';
import 'package:easy_pay_app/core/routes/app_routes_name.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:easy_pay_app/core/widgets/custom_button.dart';
import 'package:easy_pay_app/features/account_and_card/domain/entities/card_entity.dart';
import 'package:easy_pay_app/features/account_and_card/presentation/cubit/account_cubit.dart';
import 'package:easy_pay_app/features/account_and_card/presentation/cubit/card_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardTabView extends StatelessWidget {
  final List<CardEntity> cards;

  const CardTabView({super.key, required this.cards});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.scaleWidth(20)),
      child: ListView.builder(
        itemCount: cards.length + 1,
        itemBuilder: (context, index) {
          if (index == cards.length) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: context.scaleHeight(12)),
              child: Column(
                children: [
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
                  SizedBox(height: context.scaleHeight(20)),
                ],
              ),
            );
          }
          final card = cards[index];
          final cardAsset = card.cardType.toLowerCase() == 'visa'
              ? AppAssets.bankCardBlue
              : AppAssets.bankCardYellow;
          return Container(
            margin: EdgeInsets.only(bottom: context.scaleHeight(16)),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(context.scaleWidth(20)),
              child: InkWell(
                borderRadius: BorderRadius.circular(context.scaleWidth(20)),
                onTap: () async {
                  await Navigator.pushNamed(
                    context,
                    AppRoutesName.cardDetailsScreen,
                    arguments: {
                      'card': card,
                      'cubit': context.read<CardCubit>(),
                    },
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(context.scaleWidth(20)),
                  child: Stack(
                    children: [
                      Image.asset(
                        cardAsset,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      Padding(
                        padding: EdgeInsets.all(context.scaleWidth(26)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              card.cardHolderName,
                              style: AppTextStyles.titleLarge.copyWith(color: AppColors.white),
                            ),
                            SizedBox(height: context.scaleHeight(40)),
                            Text(
                              card.cardType,
                              style: AppTextStyles.titleMedium.copyWith(color: AppColors.white),
                            ),
                            SizedBox(height: context.scaleHeight(11)),
                            Text(
                              card.maskedCardNumber,
                              style: AppTextStyles.titleSmall.copyWith(color: AppColors.white),
                            ),
                            SizedBox(height: context.scaleHeight(10)),
                            Text(
                              '\$${card.bankAccount.balance}',
                              style: AppTextStyles.titleMedium.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}