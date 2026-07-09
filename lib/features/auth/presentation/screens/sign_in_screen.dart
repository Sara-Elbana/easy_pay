import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/routes/app_routes_name.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/theme/app_text_styles.dart';
import 'package:easy_pay_app/core/utils/validators.dart';
import 'package:easy_pay_app/core/widgets/custom_button.dart';
import 'package:easy_pay_app/core/widgets/custom_text_field.dart';
import 'package:easy_pay_app/core/widgets/custom_dialog.dart';
import 'package:easy_pay_app/features/auth/presentation/cubit/sign_in_cubit.dart';
import 'package:easy_pay_app/features/auth/presentation/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  bool rememberMe = false;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.03, vertical: size.height * 0.03),
        child: Form(
          key: _formKey,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("welcome".tr(),
                    style: AppTextStyles.titleLarge
                        .copyWith(color: AppColors.black)),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Text(
                  "please_enter_your_email_and_password_to_sign_in".tr(),
                  style: AppTextStyles.bodyLarge
                      .copyWith(color: AppColors.gray800),
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
                Row(
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Checkbox(
                        checkColor: AppColors.white,
                        value: rememberMe,
                        side: const BorderSide(
                            color: AppColors.gray400, width: 1),
                        activeColor: AppColors.primary,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onChanged: (value) {
                          setState(() {
                            rememberMe = value!;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                    Text(
                      "remember_me".tr(),
                      style: AppTextStyles.titleMedium.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Center(
                  child: TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => CustomDialog(
                            title: "had_very_little".tr(),
                            supTitle:
                                "you_will_be_redirected_to_the_home_page_shortly"
                                    .tr(),
                          ),
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
          listener: (context, state) {
            if (state is LoginSuccess) {
              Navigator.pushNamed(
                context,
                AppRoutesName.homeScreen,
              );
            }

            if (state is LoginError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            return SizedBox(
              width: double.infinity,
              height: 50,
              child: CustomButton(
                text: "sign_in".tr(),
                isLoading: state is LoginLoading,
                backgroundColor: Colors.green,
                onPressed: () {
                  FocusScope.of(context).unfocus();

                  if (rememberMe) {
                    // Save email and password to shared preferences or secure storage
                    if (_formKey.currentState!.validate()) {
                      context.read<SignInCubit>().login(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          );
                    } else {
                      print('accept terms and conditions');
                    }
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
