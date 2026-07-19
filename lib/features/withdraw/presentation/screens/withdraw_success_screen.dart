import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/routes/app_routes_name.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:easy_pay_app/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class WithdrawSuccessScreen extends StatelessWidget {
  const WithdrawSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: context.scaleWidth(24),
            vertical: context.scaleHeight(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: context.scaleHeight(108)),
              // Success Illustration
              Image.asset(
                'assets/images/success_illustration.png',
                width: context.scaleWidth(342),
                height: context.scaleHeight(188),
                fit: BoxFit.contain,
              ),
              SizedBox(height: context.scaleHeight(45)),
              // Title
              Text(
                'successful_withdrawal'.tr(),
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: context.scaleWidth(22),
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: context.scaleHeight(24)),
              // Description
              Text(
                'withdrawal_success_msg'.tr(),
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: context.scaleWidth(14),
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF989898),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: context.scaleHeight(32)),
              // Confirm Button
              CustomButton(
                text: 'confirm_label'.tr(),
                onPressed: () {
                  // Navigate back to the home/main screen
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
    );
  }
}
