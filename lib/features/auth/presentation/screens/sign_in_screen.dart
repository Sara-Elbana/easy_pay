import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/constants/app_assets.dart';
import 'package:easy_pay_app/core/routes/app_routes_name.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/theme/app_text_styles.dart';
import 'package:easy_pay_app/core/utils/validators.dart';
import 'package:easy_pay_app/core/widgets/custom_button.dart';
import 'package:easy_pay_app/core/widgets/custom_text_field.dart';
import 'package:easy_pay_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:easy_pay_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:easy_pay_app/features/auth/presentation/widgets/auth_footer.dart';
import 'package:easy_pay_app/features/auth/presentation/widgets/auth_illustration.dart';
import 'package:easy_pay_app/features/auth/presentation/widgets/biometric_button.dart';
import 'package:easy_pay_app/features/auth/presentation/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  bool _isFormValid = false;

  void _checkFormFilled() {
    final isValid = _phoneController.text.trim().isNotEmpty &&
        _passwordController.text.trim().isNotEmpty;

    if (_isFormValid != isValid) {
      setState(() {
        _isFormValid = isValid;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _phoneController.addListener(_checkFormFilled);
    _passwordController.addListener(_checkFormFilled);
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final biometricService = BiometricService();
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("welcome_user".tr(args: [state.user.name])),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is BiometricSuccess) {
            Navigator.pushReplacementNamed(
              context,
              AppRoutesName.homeScreen,
            );
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          final bool isLoading = state is AuthLoading;
          return Column(
            children: [
              HeaderWidget(
                title: "sign_in".tr(),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 24),
                          Text(
                            "welcome_back".tr(),
                            style: AppTextStyles.titleLarge
                                .copyWith(color: AppColors.primary),
                          ),
                          Text(
                            "hello_there_sign_in_to_continue".tr(),
                            style: AppTextStyles.titleSmall
                                .copyWith(color: AppColors.textDark),
                          ),
                          const Center(
                            child: AuthIllustration(isSignIn: true),
                          ),
                          CustomTextField(
                            controller: _phoneController,
                            hintText: "text_input".tr(),
                            focusNode: _phoneFocusNode,
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_passwordFocusNode);
                            },
                            validator: Validators.validatePhone,
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            controller: _passwordController,
                            hintText: "password".tr(),
                            isPassword: true,
                            focusNode: _passwordFocusNode,
                            textInputAction: TextInputAction.done,
                            validator: Validators.validatePassword,
                          ),
                          const SizedBox(height: 12),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context,
                                    AppRoutesName.forgotPasswordScreen);
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text(
                                "forgot_your_password".tr(),
                                style: AppTextStyles.titleSmall
                                    .copyWith(color: AppColors.textLight),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          CustomButton(
                            text: "sign_in".tr(),
                            isEnabled: _isFormValid && !isLoading,
                            isLoading: isLoading,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthCubit>().signIn(
                                      _phoneController.text.trim(),
                                      _passwordController.text,
                                    );
                              }
                            },
                          ),
                          const SizedBox(height: 24),
                          BiometricButton(
                            onTap: () {
                              context.read<AuthCubit>().biometricLogin();
                            },
                          ),
                          const SizedBox(height: 24),
                          AuthFooter(
                            title: "dont_have_an_account".tr(),
                            actionText: "sign_up".tr(),
                            routeName: AppRoutesName.signUpScreen,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
