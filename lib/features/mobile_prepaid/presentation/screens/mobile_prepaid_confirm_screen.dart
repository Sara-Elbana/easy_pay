import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/routes/app_routes_name.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:easy_pay_app/core/widgets/custom_app_bar.dart';
import 'package:easy_pay_app/core/widgets/custom_button.dart';
import 'package:easy_pay_app/core/widgets/otp_verification_widget.dart';
import 'package:easy_pay_app/features/mobile_prepaid/presentation/widgets/mobile_prepaid_confirm_info_section.dart';
import 'package:flutter/material.dart';

class MobilePrepaidConfirmScreen extends StatefulWidget {
  final String fromCard;
  final String toPhone;
  final String amount;

  const MobilePrepaidConfirmScreen({
    super.key,
    this.fromCard = '**** **** 6789',
    this.toPhone = '+8564757899',
    this.amount = '\$1000',
  });

  @override
  State<MobilePrepaidConfirmScreen> createState() => _MobilePrepaidConfirmScreenState();
}

class _MobilePrepaidConfirmScreenState extends State<MobilePrepaidConfirmScreen> {
  final TextEditingController _otpController = TextEditingController();
  bool _otpRequested = false;

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void _onConfirm() {
    Navigator.pushNamed(
      context,
      AppRoutesName.mobilePrepaidSuccessScreen,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isFormValid = _otpController.text.trim().length >= 4;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        title: 'Confirm'.tr(),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: context.scaleWidth(24),
                  vertical: context.scaleHeight(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MobilePrepaidConfirmInfoSection(
                      fromCard: widget.fromCard,
                      toPhone: widget.toPhone,
                      amount: widget.amount,
                    ),
                    SizedBox(height: context.scaleHeight(24)),
                    OTPVerificationWidget(
                      otpMode: true,
                      otpController: _otpController,
                      otpRequested: _otpRequested,
                      isBiometricVerified: false,
                      isLoading: false,
                      onGetOtpPressed: () {
                        setState(() {
                          _otpRequested = true;
                        });
                      },
                      onBiometricPressed: () {},
                      onOtpChanged: (val) {
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(context.scaleWidth(24)),
              child: CustomButton(
                text: 'Confirm'.tr(),
                isEnabled: isFormValid,
                onPressed: isFormValid ? _onConfirm : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
