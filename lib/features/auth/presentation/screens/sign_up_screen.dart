import 'package:easy_localization/easy_localization.dart';
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
import 'package:easy_pay_app/core/widgets/header_widget.dart';
import 'package:easy_pay_app/features/auth/presentation/widgets/terms_and_conditions_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _nameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  bool _agreeToTerms = false;
  bool _isFormValid = false;

  void _validateForm() {
    setState(() {
      _isFormValid = _nameController.text.trim().isNotEmpty &&
          _phoneController.text.trim().isNotEmpty &&
          _passwordController.text.trim().isNotEmpty &&
          _agreeToTerms;
    });
  }

  @override
  void initState() {
    super.initState();

    _nameController.addListener(_validateForm);
    _phoneController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _nameFocusNode.dispose();
    _passwordFocusNode.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) async {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "account_created".tr(args: [state.user.name]),
                ),
                backgroundColor: Colors.green,
              ),
            );
            await Future.delayed(const Duration(seconds: 1));
            if (!context.mounted) return;
            Navigator.pushReplacementNamed(
              context,
              AppRoutesName.mainScreen,
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
                title: "sign_up".tr(),
                leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
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
                            "welcome_to_us".tr(),
                            style: AppTextStyles.titleLarge
                                .copyWith(color: AppColors.primary),
                          ),
                          Text(
                            "hello_there_create_new_account".tr(),
                            style: AppTextStyles.titleSmall
                                .copyWith(color: AppColors.textDark),
                          ),
                          const Center(
                            child: AuthIllustration(isSignIn: false),
                          ),
                          CustomTextField(
                            controller: _nameController,
                            hintText: "name".tr(),
                            textInputAction: TextInputAction.next,
                            validator: Validators.validateName,
                            focusNode: _nameFocusNode,
                            onFieldSubmitted: (_) {
                              _phoneFocusNode.requestFocus();
                            },
                          ),
                          const SizedBox(height: 16),
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
                          const SizedBox(height: 16),
                          TermsAndConditionsWidget(
                            normalText:
                                "by_creating_an_account_you_agree_to_our".tr(),
                            highlightedText: "terms_and_conditions".tr(),
                            value: _agreeToTerms,
                            enabled: !isLoading,
                            onChanged: (value) {
                              setState(() {
                                _agreeToTerms = value;
                                _validateForm();
                              });
                            },
                          ),
                          const SizedBox(height: 24),
                          CustomButton(
                            text: "sign_up".tr(),
                            isEnabled: _isFormValid && !isLoading,
                            isLoading: isLoading,
                            onPressed: () {
                              context.read<AuthCubit>().signUp(
                                    _nameController.text.trim(),
                                    _phoneController.text.trim(),
                                    _passwordController.text,
                                  );
                            },
                          ),
                          const SizedBox(height: 24),
                          AuthFooter(
                            title: "have_an_account".tr(),
                            actionText: "sign_in".tr(),
                            routeName: AppRoutesName.signInScreen,
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
