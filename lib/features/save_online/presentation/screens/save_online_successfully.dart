import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/constants/app_assets.dart';
import 'package:easy_pay_app/core/routes/app_routes_name.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/theme/app_text_styles.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:easy_pay_app/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class SaveOnlineSuccessfully extends StatelessWidget {
  const SaveOnlineSuccessfully({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: context.scaleWidth(24),
              vertical: context.scaleHeight(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(AppAssets.addVerifyImage),
                Text(
                  "Save online successfully!",
                  style: AppTextStyles.titleLarge.copyWith(
                      fontSize: context
                          .scaleWidth(AppTextStyles.titleLarge.fontSize ?? 22),
                      color: AppColors.primary,
                      fontFamily: 'Poppins'),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: context.scaleHeight(24)),
                // Description
                const Text(
                  "Congratulations!\nYou have save money online successfully!",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textDark,
                      fontFamily: 'Poppins'),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: context.scaleHeight(32)),
                CustomButton(
                  text: 'confirm_label'.tr(),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutesName.mainScreen,
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
