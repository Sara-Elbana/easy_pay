import 'package:easy_pay_app/core/constants/app_assets.dart';
import 'package:flutter/material.dart';

class CreditCardStack extends StatelessWidget {
  final double aspectRatio;
  final double extraHeight;

  const CreditCardStack({
    super.key,
    this.aspectRatio = 1.425,
    this.extraHeight = 20,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = constraints.maxWidth;
        final cardHeight = cardWidth / aspectRatio;
        final totalHeight = cardHeight + extraHeight;

        return SizedBox(
          height: totalHeight,
          width: cardWidth,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: 24,
                left: 24,
                right: 24,
                bottom: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    AppAssets.cardBlue,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                top: 12,
                left: 12,
                right: 12,
                bottom: 12,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    AppAssets.cardGold,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 24,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    AppAssets.cardBlue,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
