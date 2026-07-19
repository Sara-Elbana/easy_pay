import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';

import 'onboarding_header.dart';

class OnboardingPageContent extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const OnboardingPageContent({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          /// Hero Section (Gradient + Phone + White Arc)
          OnboardingHeader(
            imagePath: imagePath,
          ),

          SizedBox(height: context.scaleHeight(24)),

          /// Title
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.scaleWidth(28)),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.scaleWidth(30),
                fontWeight: FontWeight.w700,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : const Color(0xff1B1B1B),
                height: 1.25,
              ),
            ),
          ),

          SizedBox(height: context.scaleHeight(18)),

          /// Description
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.scaleWidth(34)),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.scaleWidth(15),
                fontWeight: FontWeight.w400,
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.gray300
                    : const Color(0xff8E8E8E),
                height: 1.7,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
