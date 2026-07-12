import 'package:easy_pay_app/core/constants/app_assets.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthIllustration extends StatelessWidget {
  final bool isSignIn;

  const AuthIllustration({
    super.key,
    required this.isSignIn,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      width: 160,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              color: AppColors.circleBackdrop,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withAlpha(400),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Center(
              child: isSignIn ? _buildLockIcon() : _buildPhoneIcon(),
            ),
          ),
          Positioned(
            top: 20,
            right: 18,
            child: _buildDot(AppColors.dotPink, 14),
          ),
          Positioned(
            bottom: 35,
            right: 12,
            child: _buildDot(AppColors.dotBlue, 8),
          ),
          Positioned(
            bottom: 25,
            left: 18,
            child: _buildDot(AppColors.dotOrange, 12),
          ),
          Positioned(
            top: 65,
            left: 10,
            child: _buildDot(AppColors.dotTeal, 8),
          ),
          Positioned(
            top: 30,
            left: 40,
            child: _buildDot(AppColors.primary, 6),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildLockIcon() {
    return SvgPicture.asset(
      AppAssets.lockSignInImage,
      width: 50,
      height: 73,
    );
  }

  Widget _buildPhoneIcon() {
    return Stack(
      children: [
        SvgPicture.asset(
          AppAssets.phoneBackgroundImage,
          width: 55,
          height: 92,
        ),
        Positioned(
          top: 28,
          left: 15,
          child: SvgPicture.asset(
            AppAssets.userImage,
            width: 30,
            height: 27,
          ),
        )
      ],
    );
  }
}
