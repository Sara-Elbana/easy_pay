import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class OnboardingIndicator extends StatelessWidget {
  final int pageIndex;
  final int totalPages;

  const OnboardingIndicator({
    super.key,
    required this.pageIndex,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalPages,
        (index) {
          final isActive = index == pageIndex;

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: isActive ? 30 : 8,
            height: 8,
            decoration: BoxDecoration(
              color:
                  isActive ? AppColors.primary : const Color(0xffD9D9D9),
              borderRadius: BorderRadius.circular(20),
            ),
          );
        },
      ),
    );
  }
}
