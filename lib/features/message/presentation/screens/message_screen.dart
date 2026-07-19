import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/constants/app_assets.dart';
import 'package:easy_pay_app/core/routes/app_routes_name.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/widgets/custom_app_bar.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:easy_pay_app/features/message/presentation/widgets/message_card.dart';
import 'package:flutter/material.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        title: "message".tr(),
      ),
      body: Padding(
        padding: EdgeInsets.all(context.scaleWidth(24.0)),
        child: Column(
          children: [
            MessageCard(
              iconAsset: AppAssets.bankIcon,
              iconBackgroundColor: AppColors.primary,
              title: 'bank_of_america'.tr(),
              subtitle: 'Bank of America : 256486 is the au...',
              date: 'Today',
              onTap: () {
                Navigator.pushNamed(context, AppRoutesName.chatScreen);
              },
            ),
            SizedBox(height: context.scaleHeight(20)),
            MessageCard(
              iconAsset: AppAssets.accountIcon,
              iconBackgroundColor: const Color(0xFFFF4267),
              title: 'account'.tr(),
              subtitle: 'Your account is limited. Please foll...',
              date: '12/10',
              onTap: () {
                Navigator.pushNamed(context, AppRoutesName.accountScreen);
              },
            ),
            SizedBox(height: context.scaleHeight(20)),
            MessageCard(
              iconAsset: AppAssets.alertIcon,
              iconBackgroundColor: const Color(0xFF0890FE),
              title: 'alert'.tr(),
              subtitle: 'Your statement is ready for you to...',
              date: '11/10',
              onTap: () {},
            ),
            SizedBox(height: context.scaleHeight(20)),
            MessageCard(
              iconAsset: AppAssets.paypalIcon,
              iconBackgroundColor: const Color(0xFFFFAF2A),
              title: 'paypal'.tr(),
              subtitle: 'Your account has been locked. Ple...',
              date: '10/11',
              onTap: () {},
            ),
            SizedBox(height: context.scaleHeight(20)),
            MessageCard(
              iconAsset: AppAssets.withdrawIcon,
              iconBackgroundColor: const Color(0xFF52D5BA),
              title: 'withdraw'.tr(),
              subtitle: 'Dear customer, 2987456 is your co...',
              date: '10/12',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
