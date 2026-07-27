import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/routes/app_routes_name.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/theme/app_text_styles.dart';
import 'package:easy_pay_app/core/widgets/custom_app_bar.dart';
import 'package:easy_pay_app/core/widgets/custom_button.dart';
import 'package:easy_pay_app/core/widgets/custom_text_field.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:easy_pay_app/core/utils/validators.dart';
import 'package:easy_pay_app/features/auth/data/models/requests/send_otp_request.dart';
import 'package:easy_pay_app/features/auth/data/models/requests/verify_otp_request.dart';
import 'package:easy_pay_app/features/auth/presentation/cubit/forgot_password_cubit.dart';
import 'package:easy_pay_app/features/auth/presentation/cubit/forgot_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final codeController = TextEditingController();

  ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: "forgot_password_title".tr(),
      ),
      body: SafeArea(
        child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
          listener: (context, state) {
            if (state.errorMessage != null && state.errorMessage!.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage!),
                  backgroundColor: AppColors.error,
                ),
              );
            }
          },
          builder: (context, state) {
            final cubit = context.read<ForgotPasswordCubit>();

            // Sync controller values from state only if they differ
            if (phoneController.text != state.phoneNumber) {
              phoneController.text = state.phoneNumber;
            }
            if (codeController.text != state.verificationCode) {
              codeController.text = state.verificationCode;
            }

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05,
                vertical: size.height * 0.02,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: size.height * 0.01),
                    Card(
                      color: theme.brightness == Brightness.dark
                          ? AppColors.gray800
                          : Colors.white,
                      elevation: 4,
                      shadowColor: AppColors.gray200.withAlpha(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(context.scaleWidth(24)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(context.padHigh),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: !state.isCodeSent
                              ? _buildStep1(context, state, cubit, size)
                              : _buildStep2(context, state, cubit, size),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildStep1(
    BuildContext context,
    ForgotPasswordState state,
    ForgotPasswordCubit cubit,
    Size size,
  ) {
    return Column(
      key: const ValueKey('step1'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "type_phone".tr(),
          style: AppTextStyles.bodyMediumGray500,
        ),
        SizedBox(height: context.scaleHeight(8)),
        CustomTextField(
          hintText: "phone_number_format_example".tr(),
          controller: phoneController,
          keyboardType: TextInputType.phone,
          validator: Validators.validatePhone,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9+]')),
          ],
          onChanged: (val) {
            cubit.updatePhoneNumber(val);
          },
        ),
        SizedBox(height: context.scaleHeight(12)),
        Text(
          "we_texted_you_phone".tr(),
          style: AppTextStyles.bodyMediumGray500,
        ),
        SizedBox(height: context.scaleHeight(24)),
        CustomButton(
          text: "send".tr(),
          isLoading: state.isLoading,
          onPressed: state.phoneNumber.trim().isNotEmpty && !state.isLoading
              ? () {
                  if (_formKey.currentState?.validate() ?? false) {
                    FocusScope.of(context).unfocus();
                    cubit.sendOtp(SendOtpRequest(phoneNumber: state.phoneNumber.trim()));
                  }
                }
              : null,
        ),
      ],
    );
  }

  Widget _buildStep2(
    BuildContext context,
    ForgotPasswordState state,
    ForgotPasswordCubit cubit,
    Size size,
  ) {
    return Column(
      key: const ValueKey('step2'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "type_code".tr(),
          style: AppTextStyles.bodyMediumGray500,
        ),
        SizedBox(height: context.scaleHeight(8)),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: CustomTextField(
                hintText: "type_code".tr(),
                controller: codeController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                onChanged: (val) {
                  cubit.updateVerificationCode(val);
                },
              ),
            ),
            SizedBox(width: context.scaleWidth(16)),
            SizedBox(
              width: context.scaleWidth(100),
              child: CustomButton(
                text: "resend".tr(),
                onPressed: () {
                  cubit.sendOtp(SendOtpRequest(phoneNumber: state.phoneNumber));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("code_resent_success".tr()),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        SizedBox(height: context.scaleHeight(12)),
        RichText(
          text: TextSpan(
            style: AppTextStyles.bodyMediumGray500,
            children: [
              TextSpan(
                  text: "we_texted_you_code".tr().replaceAll("{}", "").trim()),
              const TextSpan(text: " "),
              TextSpan(
                text: state.phoneNumber,
                style: AppTextStyles.titleMediumPrimary,
              ),
            ],
          ),
        ),
        SizedBox(height: context.scaleHeight(12)),
        Text(
          "code_expiry_notice".tr(),
          style: AppTextStyles.bodyMediumGray400,
        ),
        SizedBox(height: context.scaleHeight(24)),
        CustomButton(
          text: "change_password".tr(),
          isLoading: state.isLoading,
          onPressed: state.verificationCode.trim().isNotEmpty && !state.isLoading
              ? () async {
                  FocusScope.of(context).unfocus();
                  await cubit.verifyOtp(
                    VerifyOtpRequest(
                      phoneNumber: state.phoneNumber.trim(),
                      code: state.verificationCode.trim(),
                    ),
                  );
                  if (context.mounted && cubit.state.isCodeVerified) {
                    Navigator.pushNamed(
                      context,
                      AppRoutesName.changePasswordScreen,
                    );
                  }
                }
              : null,
        ),
        SizedBox(height: context.scaleHeight(16)),
        Center(
          child: TextButton(
            onPressed: () {
              cubit.changePhoneNumber();
            },
            child: Text(
              "change_phone_number".tr(),
              style: AppTextStyles.titleMediumPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
