import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

import 'custom_arc_clipper.dart';

class OnboardingHeader extends StatelessWidget {
  final String imagePath;

  const OnboardingHeader({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 420,
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          /// Background Gradient
          Container(
            height: 310,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xffDDF8DF),
                  Color(0xffF8FFF8),
                ],
              ),
            ),
          ),

          /// Phone Image
          Positioned(
            top: 20,
            child: Transform.translate(
              offset: const Offset(0, -5),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withOpacity(0.25),
                      blurRadius: 35,
                      offset: const Offset(0, 18),
                    ),
                  ],
                ),
                child: Image.asset(
                  imagePath,
                  height: 380,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          /// White Arc (Above Phone)
          Positioned(
            bottom: 0,
            left: -30,
            right: -30,
            child: ClipPath(
              clipper: CustomArcClipper(),
              child: Container(
                height: 180,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
