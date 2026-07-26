import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';

class WithdrawIllustration extends StatelessWidget {
  const WithdrawIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/images/success_illustration.png',
        width: context.scaleWidth(342),
        height: context.scaleHeight(188),
        fit: BoxFit.contain,
      ),
    );
  }
}
