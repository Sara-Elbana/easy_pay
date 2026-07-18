import 'package:easy_pay_app/core/constants/app_assets.dart';
import 'package:easy_pay_app/core/routes/app_routes_name.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/widgets/custom_app_bar.dart';
import 'package:easy_pay_app/features/bottomNav/message/presentation/widgets/message_card.dart';
import 'package:flutter/material.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(
        title: "Message",
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            MessageCard(
              iconAsset: AppAssets.bankIcon,
              iconBackgroundColor: AppColors.primary,
              title: 'Bank of America',
              subtitle: 'Bank of America : 256486 is the au...',
              date: 'Today',
              onTap: () {
                Navigator.pushNamed(context, AppRoutesName.chatScreen);
              },
            ),
            const SizedBox(height: 20),
            MessageCard(
              iconAsset: AppAssets.accountIcon,
              iconBackgroundColor: const Color(0xFFFF4267),
              title: 'Account',
              subtitle: 'Your account is limited. Please foll...',
              date: '12/10',
              onTap: () {
                Navigator.pushNamed(context, AppRoutesName.accountScreen);
              },
            ),
            const SizedBox(height: 20),
            MessageCard(
              iconAsset: AppAssets.alertIcon,
              iconBackgroundColor: const Color(0xFF0890FE),
              title: 'Alert',
              subtitle: 'Your statement is ready for you to...',
              date: '11/10',
              onTap: () {},
            ),
            const SizedBox(height: 20),
            MessageCard(
              iconAsset: AppAssets.paypalIcon,
              iconBackgroundColor: const Color(0xFFFFAF2A),
              title: 'Paypal',
              subtitle: 'Your account has been locked. Ple...',
              date: '10/11',
              onTap: () {},
            ),
            const SizedBox(height: 20),
            MessageCard(
              iconAsset: AppAssets.withdrawIcon,
              iconBackgroundColor: const Color(0xFF52D5BA),
              title: 'Withdraw',
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
