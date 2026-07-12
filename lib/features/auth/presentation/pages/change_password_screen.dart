import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/routes/app_routes_name.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/theme/app_text_styles.dart';
import 'package:easy_pay_app/core/widgets/custom_button.dart';
import 'package:easy_pay_app/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatelessWidget {
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final isButtonEnabled = ValueNotifier<bool>(false);

  ChangePasswordScreen({super.key}) {
    void listener() {
      isButtonEnabled.value = newPasswordController.text.isNotEmpty &&
          confirmPasswordController.text.isNotEmpty;
    }
    newPasswordController.addListener(listener);
    confirmPasswordController.addListener(listener);
  }

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
          "change_password".tr(),
          style: AppTextStyles.titleLarge.copyWith(
            color: theme.textTheme.titleLarge?.color,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
            vertical: size.height * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.01),
              Card(
                color: theme.brightness == Brightness.dark
                    ? AppColors.gray800
                    : Colors.white,
                elevation: 4,
                shadowColor: AppColors.gray200.withValues(alpha: 0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "new_password".tr(),
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.gray500,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CustomTextField(
                        hintText: "new_password".tr(),
                        isPassword: true,
                        controller: newPasswordController,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "confirm_password".tr(),
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.gray500,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CustomTextField(
                        hintText: "confirm_password".tr(),
                        isPassword: true,
                        controller: confirmPasswordController,
                        textInputAction: TextInputAction.done,
                      ),
                      const SizedBox(height: 24),
                      ValueListenableBuilder<bool>(
                        valueListenable: isButtonEnabled,
                        builder: (context, enabled, _) {
                          return CustomButton(
                            text: "change_password".tr(),
                            backgroundColor: enabled
                                ? AppColors.primary
                                : AppColors.gray200,
                            foregroundColor: enabled
                                ? Colors.white
                                : AppColors.gray400,
                            onPressed: enabled
                                ? () {
                                    FocusScope.of(context).unfocus();
                                    // Navigate to success screen
                                    Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      AppRoutesName.changePasswordSuccessScreen,
                                      (route) => false,
                                    );
                                  }
                                : null,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
