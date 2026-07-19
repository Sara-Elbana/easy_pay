import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/constants/app_assets.dart';
import 'package:easy_pay_app/core/routes/app_routes_name.dart';
import 'package:easy_pay_app/features/bottomNav/presentation/widgets/grid_menu_item.dart';
import 'package:flutter/material.dart';

class HomeMenuGrid extends StatelessWidget {
  const HomeMenuGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1,
      children: [
        GridMenuItem(
          iconPath: AppAssets.accountAndCardIcon,
          title: "account_and_card".tr(),
          onTap: () {
            Navigator.pushNamed(context, AppRoutesName.accountScreen);
          },
        ),
        GridMenuItem(
          iconPath: AppAssets.transferIcon,
          title: "transfer".tr(),
          onTap: () {
            Navigator.pushNamed(context, AppRoutesName.transferScreen);
          },
        ),
        GridMenuItem(
          iconPath: AppAssets.withdrawIcon,
          title: "withdraw".tr(),
          onTap: () {
            Navigator.pushNamed(context, AppRoutesName.withdrawScreen);
          },
        ),
        GridMenuItem(
          iconPath: AppAssets.prepaidIcon,
          title: "mobile_prepaid".tr(),
          onTap: () {},
        ),
        GridMenuItem(
          iconPath: AppAssets.payTheBillIcon,
          title: "pay_the_bill".tr(),
          onTap: () {
              Navigator.pushNamed(context, AppRoutesName.payTheBillScreen);
            },
        ),
        GridMenuItem(
          iconPath: AppAssets.onlineIcon,
          title: "save_online".tr(),
          onTap: () {},
        ),
        GridMenuItem(
          iconPath: AppAssets.creditCardIcon,
          title: "credit_card".tr(),
          onTap: () {},
        ),
        GridMenuItem(
          iconPath: AppAssets.transactionReportIcon,
          title: "transaction_report".tr(),
          onTap: () {},
        ),
        GridMenuItem(
          iconPath: AppAssets.beneficiaryIcon,
          title: "beneficiary".tr(),
          onTap: () {},
        ),
      ],
    );
  }
}
