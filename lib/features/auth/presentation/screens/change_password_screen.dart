import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/routes/app_routes_name.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/theme/app_text_styles.dart';
import 'package:easy_pay_app/core/widgets/custom_app_bar.dart';
import 'package:easy_pay_app/core/widgets/custom_button.dart';
import 'package:easy_pay_app/core/widgets/custom_text_field.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:easy_pay_app/core/utils/validators.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
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
      appBar: CustomAppBar(
        title: "change_password".tr(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
            vertical: size.height * 0.02,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: context.scaleHeight(10)),
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
                  padding: EdgeInsets.all(context.scaleWidth(24)),
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
                      SizedBox(height: context.scaleHeight(8)),
                      CustomTextField(
                        hintText: "new_password".tr(),
                        isPassword: true,
                        controller: newPasswordController,
                        textInputAction: TextInputAction.next,
                        validator: Validators.validatePassword,
                      ),
                      SizedBox(height: context.scaleHeight(16)),
                      Text(
                        "confirm_password".tr(),
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.gray500,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: context.scaleHeight(8)),
                      CustomTextField(
                        hintText: "confirm_password".tr(),
                        isPassword: true,
                        controller: confirmPasswordController,
                        textInputAction: TextInputAction.done,
                        validator: (value) => Validators.validateConfirmPassword(
                          value,
                          newPasswordController.text,
                        ),
                      ),
                      SizedBox(height: context.scaleHeight(24)),
                      ValueListenableBuilder<bool>(
                        valueListenable: isButtonEnabled,
                        builder: (context, enabled, _) {
                          return CustomButton(
                            text: "change_password".tr(),
                            onPressed: enabled
                                ? () {
                                    if (_formKey.currentState?.validate() ?? false) {
                                      FocusScope.of(context).unfocus();
                                      // Navigate to success screen
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        AppRoutesName.changePasswordSuccessScreen,
                                        (route) => false,
                                      );
                                    }
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
      ),
    );
  }
}
