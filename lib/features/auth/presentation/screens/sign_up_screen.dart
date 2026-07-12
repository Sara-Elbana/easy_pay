import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/routes/app_routes_name.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/widgets/custom_button.dart';
import 'package:easy_pay_app/core/widgets/custom_text_field.dart';
import 'package:easy_pay_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:easy_pay_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:easy_pay_app/features/auth/presentation/widgets/auth_illustration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _agreeToTerms = false;
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_validateForm);
    _usernameController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
  }

  void _validateForm() {
    setState(() {
      _isFormValid = _nameController.text.trim().isNotEmpty &&
          _usernameController.text.trim().isNotEmpty &&
          _passwordController.text.trim().isNotEmpty &&
          _agreeToTerms;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Account created for ${state.user.name}!'),
                backgroundColor: Colors.green,
              ),
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
              Container(
                padding: EdgeInsets.only(
                  top: statusBarHeight + 10,
                  bottom: 20,
                  left: 10,
                  right: 20,
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "sign_up".tr(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 24),
                        Text(
                          "welcome_to_us".tr(),
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        Text(
                          "hello_there_create_new_account".tr(),
                          style: const TextStyle(
                            fontSize: 15,
                            color: AppColors.textDark,
                          ),
                        ),
                        const Center(
                          child: AuthIllustration(isSignIn: false),
                        ),
                        CustomTextField(
                          controller: _nameController,
                          hintText: "name".tr(),
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          controller: _usernameController,
                          hintText: "text_input".tr(),
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          controller: _passwordController,
                          hintText: "password".tr(),
                          isPassword: true,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: _agreeToTerms,
                              fillColor:
                                  WidgetStateProperty.resolveWith((states) {
                                return Colors.white;
                              }),
                              checkColor: AppColors.primary,
                              activeColor: AppColors.primary,
                              side: WidgetStateBorderSide.resolveWith((states) {
                                return BorderSide(
                                  color: states.contains(WidgetState.selected)
                                      ? AppColors.primary
                                      : Colors.grey,
                                  width: 1.4,
                                );
                              }),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              onChanged: isLoading
                                  ? null
                                  : (value) {
                                      setState(() {
                                        _agreeToTerms = value ?? false;
                                        _validateForm();
                                      });
                                    },
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: isLoading
                                    ? null
                                    : () {
                                        setState(() {
                                          _agreeToTerms = !_agreeToTerms;
                                          _validateForm();
                                        });
                                      },
                                child: RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w400,
                                      //height: 1.3,
                                      color: AppColors.black,
                                      fontFamily: 'Lato',
                                    ),
                                    children: [
                                      TextSpan(
                                        text:
                                            "by_creating_an_account_you_agree_to_our"
                                                .tr(),
                                      ),
                                      TextSpan(
                                        text: "terms_and_conditions".tr(),
                                        style: const TextStyle(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        CustomButton(
                          text: "sign_up".tr(),
                          isEnabled: _isFormValid && !isLoading,
                          isLoading: isLoading,
                          onPressed: () {
                            context.read<AuthCubit>().signUp(
                                  _nameController.text.trim(),
                                  _usernameController.text.trim(),
                                  _passwordController.text,
                                );
                          },
                        ),
                        const SizedBox(height: 24),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "have_an_account".tr(),
                                style: const TextStyle(
                                  color: AppColors.textDark,
                                  fontSize: 14,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                      context, AppRoutesName.signInScreen);
                                },
                                child: Text(
                                  "sign_in".tr(),
                                  style: const TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
