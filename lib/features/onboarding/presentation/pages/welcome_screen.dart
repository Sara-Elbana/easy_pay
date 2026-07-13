import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/routes/app_routes_name.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final logoSize = screenWidth * 0.67;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      width: logoSize,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
              child: Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'sign_up'.tr(),
                     // backgroundColor: Colors.white,
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutesName.signUpScreen);
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomButton(
                      text: 'sign_in'.tr(),
                    //  backgroundColor: const Color(0xFFB7E65C),
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutesName.signInScreen);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
