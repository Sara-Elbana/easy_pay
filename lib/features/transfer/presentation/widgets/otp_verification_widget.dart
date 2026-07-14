import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/constants/app_assets.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OTPVerificationWidget extends StatelessWidget {
  final bool otpMode;
  final TextEditingController otpController;
  final bool otpRequested;
  final bool isBiometricVerified;
  final bool isLoading;
  final VoidCallback onGetOtpPressed;
  final VoidCallback onBiometricPressed;
  final ValueChanged<String> onOtpChanged;

  const OTPVerificationWidget({
    super.key,
    required this.otpMode,
    required this.otpController,
    required this.otpRequested,
    required this.isBiometricVerified,
    required this.isLoading,
    required this.onGetOtpPressed,
    required this.onBiometricPressed,
    required this.onOtpChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'get_otp_to_verify'.tr(),
          style: const TextStyle(
            color: AppColors.textLight,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        if (otpMode)
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: CustomTextField(
                  controller: otpController,
                  hintText: 'OTP',
                  keyboardType: TextInputType.number,
                  onChanged: onOtpChanged,
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: onGetOtpPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: otpRequested ? AppColors.primary : Colors.white,
                    foregroundColor: otpRequested ? Colors.white : AppColors.primary,
                    side: BorderSide(
                      color: AppColors.primary,
                      width: otpRequested ? 0 : 1.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                  child: Text(
                    'get_otp'.tr(),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          )
        else
          Center(
            child: GestureDetector(
              onTap: onBiometricPressed,
              child: Container(
                width: 80,
                height: 80,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isBiometricVerified
                      ? Colors.green.withValues(alpha: 0.1)
                      : AppColors.gray100,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isBiometricVerified ? Colors.green : AppColors.gray200,
                    width: 1.5,
                  ),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                        strokeWidth: 3,
                      )
                    : isBiometricVerified
                        ? const Icon(
                            Icons.check,
                            color: Colors.green,
                            size: 40,
                          )
                        : SvgPicture.asset(
                            AppAssets.fingerprint,
                            colorFilter: const ColorFilter.mode(
                              AppColors.primary,
                              BlendMode.srcIn,
                            ),
                          ),
              ),
            ),
          ),
      ],
    );
  }
}
