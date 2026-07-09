import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_button.dart';

class OnboardingNavButtons extends StatelessWidget {
  final int pageIndex;
  final int totalPages;
  final VoidCallback onSkip;
  final VoidCallback onNext;
  final VoidCallback onGetStarted;

  const OnboardingNavButtons({
    super.key,
    required this.pageIndex,
    required this.totalPages,
    required this.onSkip,
    required this.onNext,
    required this.onGetStarted,
  });

  bool get isLastPage => pageIndex == totalPages - 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          if (!isLastPage) ...[
            Expanded(
              child: CustomButton(
                text: 'Skip',
                backgroundColor: Colors.white,
                onPressed: onSkip,
              ),
            ),
            const SizedBox(width: 16),
          ],
          Expanded(
            child: CustomButton(
              text: isLastPage ? 'Get Started' : 'Next',
              backgroundColor: const Color(0xFFB7E65C),
              onPressed: isLastPage ? onGetStarted : onNext,
            ),
          ),
        ],
      ),
    );
  }
}
