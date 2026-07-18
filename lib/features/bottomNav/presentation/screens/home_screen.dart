import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/constants/app_assets.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/widgets/header_widget.dart';
import 'package:easy_pay_app/features/bottomNav/presentation/widgets/credit_card_stack.dart';
import 'package:easy_pay_app/features/bottomNav/presentation/widgets/home_menu_grid.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        children: [
          HeaderWidget(
            title: "hi_user".tr(args: ["Push Puttichai"]),
            leading: const CircleAvatar(
              radius: 22,
              backgroundImage: AssetImage(AppAssets.avatarImage),
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(context.scaleWidth(30)),
                  topRight: Radius.circular(context.scaleWidth(30)),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal:
                      context.padMedium, // Scale horizontal padding (base: 16)
                  vertical: context.scaleHeight(16),
                ),
                child: const Column(
                  children: [
                    CreditCardStack(),
                    HomeMenuGrid(),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
