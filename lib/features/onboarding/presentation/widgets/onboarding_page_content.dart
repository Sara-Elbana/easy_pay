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

          const SizedBox(height: 24),

          /// Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: Color(0xff1B1B1B),
                height: 1.25,
              ),
            ),
          ),

          const SizedBox(height: 18),

          /// Description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 34),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Color(0xff8E8E8E),
                height: 1.7,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
