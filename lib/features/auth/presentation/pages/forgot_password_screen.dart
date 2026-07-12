import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/routes/app_routes_name.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/theme/app_text_styles.dart';
import 'package:easy_pay_app/core/widgets/custom_button.dart';
import 'package:easy_pay_app/core/widgets/custom_text_field.dart';
import 'package:easy_pay_app/core/utils/validators.dart';
import 'package:easy_pay_app/features/auth/presentation/cubit/forgot_password_cubit.dart';
import 'package:easy_pay_app/features/auth/presentation/cubit/forgot_password_state.dart';
import 'package:flutter/material.dart';
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
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: theme.iconTheme.color ?? AppColors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "forgot_password_title".tr(),
          style: AppTextStyles.titleLarge.copyWith(
            color: theme.textTheme.titleLarge?.color,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
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
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
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
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.gray500,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        CustomTextField(
          hintText: "e.g. (+20) 1234567890",
          controller: phoneController,
          keyboardType: TextInputType.text,
          validator: Validators.validatePhone,
          onChanged: (val) {
            cubit.updatePhoneNumber(val);
          },
        ),
        const SizedBox(height: 12),
        Text(
          "we_texted_you_phone".tr(),
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.gray500,
          ),
        ),
        const SizedBox(height: 24),
        CustomButton(
          text: "send".tr(),
          onPressed: state.phoneNumber.trim().isNotEmpty
              ? () {
                  if (_formKey.currentState?.validate() ?? false) {
                    FocusScope.of(context).unfocus();
                    cubit.sendCode();
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
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.gray500,
            fontWeight: FontWeight.w500,
          ),
        ),
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
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: size.height * 0.02,
              ).copyWith(
                right: size.width * 0.02,
              ),
              child: SizedBox(
                width: 110,
                child: CustomButton(
                  text: "resend".tr(),
                  onPressed: () {
                    cubit.sendCode();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Code resent successfully!".tr()),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        RichText(
          text: TextSpan(
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.gray500,
            ),
            children: [
              TextSpan(
                  text: "we_texted_you_code".tr().replaceAll("{}", "").trim()),
              const TextSpan(text: " "),
              TextSpan(
                text: state.phoneNumber,
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          "code_expiry_notice".tr(),
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.gray400,
            fontSize: 13,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 24),
        CustomButton(
          text: "change_password".tr(),
          onPressed: state.verificationCode.trim().isNotEmpty
              ? () {
                  FocusScope.of(context).unfocus();
                  Navigator.pushNamed(
                    context,
                    AppRoutesName.changePasswordScreen,
                  );
                }
              : null,
        ),
        const SizedBox(height: 16),
        Center(
          child: TextButton(
            onPressed: () {
              cubit.changePhoneNumber();
            },
            child: Text(
              "change_phone_number".tr(),
              style: AppTextStyles.titleMedium.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
