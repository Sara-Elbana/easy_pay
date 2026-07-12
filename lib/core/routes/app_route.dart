import 'package:easy_pay_app/features/auth/presentation/cubit/sign_in_cubit.dart';
import 'package:easy_pay_app/features/auth/presentation/pages/sign_in_screen.dart';
import 'package:easy_pay_app/features/auth/presentation/pages/reset_password_screen.dart';
import 'package:easy_pay_app/features/auth/presentation/pages/change_password_screen.dart';
import 'package:easy_pay_app/features/auth/presentation/pages/change_password_success_screen.dart';
import 'package:easy_pay_app/features/auth/presentation/cubit/forgot_password_cubit.dart';
import 'package:easy_pay_app/features/home/persentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_pay_app/core/di/service_locator.dart';
import 'package:easy_pay_app/core/routes/app_routes_name.dart';
import 'package:easy_pay_app/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:easy_pay_app/features/onboarding/presentation/pages/onboarding_screen.dart';
import 'package:easy_pay_app/features/onboarding/presentation/pages/splash_screen.dart';
import 'package:easy_pay_app/features/onboarding/presentation/pages/welcome_screen.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> routes = {
    AppRoutesName.splashScreen: (_) => const SplashScreen(),
    AppRoutesName.onboardingScreen: (_) => BlocProvider(
      create: (_) => getIt<OnboardingCubit>(),
      child: const OnboardingScreen(),
    ),
    AppRoutesName.welcomeScreen: (_) => const WelcomeScreen(),
    AppRoutesName.signInScreen: (context) => BlocProvider(
      create: (_) => getIt<SignInCubit>(),
      child: SignInScreen(),
    ),
    AppRoutesName.homeScreen: (_) => const HomeScreen(),
    AppRoutesName.resetPasswordScreen: (_) => BlocProvider(
          create: (_) => getIt<ForgotPasswordCubit>(),
          child: ResetPasswordScreen(),
        ),
    AppRoutesName.changePasswordScreen: (_) => ChangePasswordScreen(),
    AppRoutesName.changePasswordSuccessScreen: (_) => const ChangePasswordSuccessScreen(),
  };
}