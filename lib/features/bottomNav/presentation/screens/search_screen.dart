import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/constants/app_assets.dart';
import 'package:easy_pay_app/core/routes/app_routes_name.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:easy_pay_app/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import '../widgets/search_card_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: 'search'.tr(),
        centerTitle: false,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: context.scaleWidth(24),
            vertical: context.scaleHeight(16),
          ),
          children: [
            SearchCardWidget(
              title: 'branch'.tr(),
              subtitle: 'search_for_branch'.tr(),
              imageAsset: AppAssets.branchIllus,
              onTap: () {
                Navigator.pushNamed(context, AppRoutesName.mapSearchScreen);
              },
            ),
            SearchCardWidget(
              title: 'interest_rate'.tr(),
              subtitle: 'search_for_interest_rate'.tr(),
              imageAsset: AppAssets.interestIllus,
              onTap: () {
                Navigator.pushNamed(context, AppRoutesName.interestRateScreen);
              },
            ),
            SearchCardWidget(
              title: 'exchange_rate'.tr(),
              subtitle: 'search_for_exchange_rate'.tr(),
              imageAsset: AppAssets.exchangeRateIllus,
              onTap: () {
                Navigator.pushNamed(context, AppRoutesName.exchangeRateScreen);
              },
            ),
            SearchCardWidget(
              title: 'exchange'.tr(),
              subtitle: 'exchange_amount_of_money'.tr(),
              imageAsset: AppAssets.exchangeIllus,
              onTap: () {
                Navigator.pushNamed(context, AppRoutesName.exchangeScreen);
              },
            ),
          ],
        ),
      ),
    );
  }
}
