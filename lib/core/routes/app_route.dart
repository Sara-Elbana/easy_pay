import 'package:easy_pay_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:easy_pay_app/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:easy_pay_app/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:easy_pay_app/features/home/presentation/screens/home_Screen.dart';
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
          create: (_) => getIt<AuthCubit>(),
          child: const SignInScreen(),
        ),
    AppRoutesName.signUpScreen: (context) => BlocProvider(
      create: (_) => getIt<AuthCubit>(),
      child: const SignUpScreen(),
    ),

    AppRoutesName.homeScreen: (_) => const HomeScreen(),
  };
}
