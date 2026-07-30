import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/routes/app_routes_name.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/theme/app_text_styles.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:easy_pay_app/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class MobilePrepaidSuccessScreen extends StatelessWidget {
  const MobilePrepaidSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.scaleWidth(24),
            vertical: context.scaleHeight(20),
          ),
          child: Column(
            children: [
              const Spacer(),
              Image.asset(
                'assets/images/success_illustration.png',
                height: context.scaleHeight(220),
                fit: BoxFit.contain,
              ),
              SizedBox(height: context.scaleHeight(40)),
              Text(
                'Payment success!'.tr(),
                style: AppTextStyles.titleLargePrimary,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: context.scaleHeight(16)),
              Text(
                'You have successfully paid mobile prepaid!'.tr(),
                style: AppTextStyles.titleMediumSmallDark,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: context.scaleHeight(32)),
              CustomButton(
                text: 'Confirm'.tr(),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutesName.mainScreen,
                    (route) => false,
                  );
                },
              ),
              const Spacer(flex: 4),
            ],
          ),
        ),
      ),
    );
  }
}
