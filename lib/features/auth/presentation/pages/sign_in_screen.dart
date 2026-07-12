import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/routes/app_routes_name.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/theme/app_text_styles.dart';
import 'package:easy_pay_app/core/utils/validators.dart';
import 'package:easy_pay_app/core/widgets/custom_button.dart';
import 'package:easy_pay_app/core/widgets/custom_text_field.dart';
import 'package:easy_pay_app/features/auth/presentation/cubit/sign_in_cubit.dart';
import 'package:easy_pay_app/features/auth/presentation/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  SignInScreen({super.key});

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
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.03, vertical: size.height * 0.03),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("welcome".tr(),
                    style: AppTextStyles.titleLarge.copyWith(
                      color: theme.textTheme.titleLarge?.color,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    )),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Text(
                  "please_enter_your_email_and_password_to_sign_in".tr(),
                  style: AppTextStyles.bodyLarge
                      .copyWith(color: theme.textTheme.bodyLarge?.color),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                CustomTextField(
                  hintText: "email_address".tr(),
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  validator: Validators.validateEmail,
                  focusNode: emailFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(passwordFocusNode);
                  },
                ),
                CustomTextField(
                  hintText: "password".tr(),
                  keyboardType: TextInputType.visiblePassword,
                  isPassword: true,
                  controller: passwordController,
                  validator: Validators.validatePassword,
                  focusNode: passwordFocusNode,
                  textInputAction: TextInputAction.done,
                ),
                BlocBuilder<SignInCubit, LoginState>(
                  buildWhen: (previous, current) => previous.rememberMe != current.rememberMe,
                  builder: (context, state) {
                    final cubit = context.read<SignInCubit>();
                    return Row(
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Checkbox(
                            checkColor: AppColors.white,
                            value: state.rememberMe,
                            side: const BorderSide(
                                color: AppColors.gray400, width: 1),
                            activeColor: AppColors.primary,
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            onChanged: (value) {
                              cubit.toggleRememberMe(value ?? false);
                            },
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.02,
                        ),
                        Text(
                          "remember_me".tr(),
                          style: AppTextStyles.titleMedium.copyWith(
                            color: theme.textTheme.titleMedium?.color,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Center(
                  child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutesName.resetPasswordScreen,
                        );
                      },
                      child: Text(
                        "forget_password".tr(),
                        style: AppTextStyles.titleMedium
                            .copyWith(color: AppColors.primary),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: BlocConsumer<SignInCubit, LoginState>(
          listenWhen: (previous, current) => previous.isSuccess != current.isSuccess || previous.errorMessage != current.errorMessage,
          listener: (context, state) {
            if (state.isSuccess) {
              Navigator.pushNamed(
                context,
                AppRoutesName.homeScreen,
              );
            }

            if (state.errorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage!)),
              );
            }
          },
          builder: (context, state) {
            return CustomButton(
              text: "sign_in".tr(),
              isLoading: state.isLoading,
              onPressed: () {
                FocusScope.of(context).unfocus();

                if (state.rememberMe) {
                  if (_formKey.currentState!.validate()) {
                    context.read<SignInCubit>().login(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        );
                  } else {
                    debugPrint('Validation failed');
                  }
                }
              },
            );
          },
        ),
      ),
    );
  }
}
