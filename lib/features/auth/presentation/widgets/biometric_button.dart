import 'package:easy_pay_app/core/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BiometricButton extends StatelessWidget {
  final VoidCallback onTap;

  const BiometricButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(50),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            AppAssets.fingerprint,
          ),
        ),
      ),
    );
  }
}