import 'package:easy_pay_app/core/constants/app_assets.dart';
import 'package:easy_pay_app/core/core.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:easy_pay_app/features/bottomNav/presentation/widgets/search_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:easy_pay_app/core/widgets/custom_app_bar.dart';
import 'package:easy_localization/easy_localization.dart';

class PayTheBillScreen extends StatelessWidget {
  const PayTheBillScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(title: "Pay_the_bill".tr()),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: context.scaleWidth(24),
          vertical: context.scaleHeight(16),
        ),
        children: [
          SearchCardWidget(
            title: "Electric bill",
            subtitle: "Pay electric bill this month",
            imageAsset: AppAssets.electricBillImage,
            onTap: () {},
          ),
          SearchCardWidget(
            title: "Water bill",
            subtitle: "Pay water bill this month",
            imageAsset: AppAssets.waterBillImage,
            onTap: () {},
          ),
          SearchCardWidget(
            title: "Mobile bill",
            subtitle: "Pay mobile bill this month",
            imageAsset: AppAssets.mobileBillImage,
            onTap: () {},
          ),
          SearchCardWidget(
            title: "Internet bill",
            subtitle: "Pay internet bill this month",
            imageAsset: AppAssets.internetBillImage,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
