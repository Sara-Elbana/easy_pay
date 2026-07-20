import 'package:easy_pay_app/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:easy_pay_app/features/interest_rate/presentation/screens/interest_rate_screen.dart';
import 'package:easy_pay_app/features/pay_the_bill/presentation/screens/pay_the_bill_screen.dart';
import 'package:easy_pay_app/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:easy_pay_app/features/auth/presentation/screens/change_password_screen.dart';
import 'package:easy_pay_app/features/auth/presentation/screens/change_password_success_screen.dart';
import 'package:easy_pay_app/features/auth/presentation/cubit/forgot_password_cubit.dart';
import 'package:easy_pay_app/features/bottomNav/presentation/screens/home_screen.dart';
import 'package:easy_pay_app/features/bottomNav/presentation/screens/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:easy_pay_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:easy_pay_app/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_pay_app/core/di/service_locator.dart';
import 'package:easy_pay_app/core/routes/app_routes_name.dart';
import 'package:easy_pay_app/features/beneficiary/domain/entities/beneficiary.dart';
import 'package:easy_pay_app/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:easy_pay_app/features/onboarding/presentation/pages/onboarding_screen.dart';
import 'package:easy_pay_app/features/onboarding/presentation/pages/splash_screen.dart';
import 'package:easy_pay_app/features/onboarding/presentation/pages/welcome_screen.dart';
import 'package:easy_pay_app/features/transfer/presentation/screens/transfer_screen.dart';
import 'package:easy_pay_app/features/transfer/presentation/screens/confirm_screen.dart';
import 'package:easy_pay_app/features/transfer/presentation/screens/success_transfer_screen.dart';
import 'package:easy_pay_app/features/beneficiary/presentation/screens/beneficiary_directory_screen.dart';
import 'package:easy_pay_app/features/beneficiary/presentation/screens/add_beneficiary_screen.dart';
import 'package:easy_pay_app/features/beneficiary/presentation/screens/beneficiary_detail_screen.dart';
import 'package:easy_pay_app/features/transfer/presentation/cubit/transfer_cubit.dart';
import 'package:easy_pay_app/features/beneficiary/presentation/cubit/beneficiary_cubit.dart';
import 'package:easy_pay_app/features/bottomNav/presentation/screens/main_screen.dart';
import 'package:easy_pay_app/features/exchange_rate/presentation/screens/exchange_rate_screen.dart';
import 'package:easy_pay_app/features/exchange_rate/presentation/cubit/exchange_rate_cubit.dart';
import 'package:easy_pay_app/features/exchange/presentation/screens/exchange_screen.dart';
import 'package:easy_pay_app/features/exchange/presentation/cubit/exchange_cubit.dart';
import 'package:easy_pay_app/features/setting/app_information/presentation/screens/app_information_screen.dart';
import 'package:easy_pay_app/features/message/presentation/screens/account_screen.dart';
import 'package:easy_pay_app/features/message/presentation/screens/chat_screen.dart';
import 'package:easy_pay_app/features/message/presentation/screens/card_details_screen.dart';
import 'package:easy_pay_app/features/withdraw/presentation/screens/withdraw_screen.dart';
import 'package:easy_pay_app/features/withdraw/presentation/screens/withdraw_success_screen.dart';
import 'package:easy_pay_app/features/Branch/presentation/cubit/map_cubit.dart';
import 'package:easy_pay_app/features/Branch/presentation/screens/map_search_screen.dart';

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
    AppRoutesName.forgotPasswordScreen: (_) => BlocProvider(
          create: (_) => getIt<ForgotPasswordCubit>(),
          child: ForgotPasswordScreen(),
        ),
    AppRoutesName.changePasswordScreen: (_) => ChangePasswordScreen(),
    AppRoutesName.changePasswordSuccessScreen: (_) =>
        const ChangePasswordSuccessScreen(),
    AppRoutesName.homeScreen: (_) => const HomeScreen(),
    AppRoutesName.transferScreen: (_) => BlocProvider(
          create: (_) => getIt<TransferCubit>(),
          child: TransferScreen(),
        ),
    AppRoutesName.confirmScreen: (_) => ConfirmScreen(),
    AppRoutesName.successTransferScreen: (_) => const SuccessTransferScreen(),
    AppRoutesName.mainScreen: (_) => const MainScreen(),
    AppRoutesName.exchangeRateScreen: (_) => BlocProvider(
          create: (_) => getIt<ExchangeRateCubit>()..getExchangeRates(),
          child: const ExchangeRateScreen(),
        ),
    AppRoutesName.exchangeScreen: (_) => BlocProvider(
          create: (_) => getIt<ExchangeCubit>(),
          child: const ExchangeScreen(),
        ),
    AppRoutesName.settingScreen: (_) => const SettingScreen(),
    AppRoutesName.appInformationScreen: (_) => const AppInformationScreen(),
    AppRoutesName.accountScreen: (_) => const AccountScreen(),
    AppRoutesName.chatScreen: (_) => const ChatScreen(),
    AppRoutesName.cardDetailsScreen: (_) => const CardDetailsScreen(),
    AppRoutesName.withdrawScreen: (_) => const WithdrawScreen(),
    AppRoutesName.withdrawSuccessScreen: (_) => const WithdrawSuccessScreen(),
    AppRoutesName.mapSearchScreen: (_) => BlocProvider(
          create: (_) => getIt<MapCubit>(),
          child: const MapSearchScreen(),
        ),
    AppRoutesName.payTheBillScreen: (_) => const PayTheBillScreen(),
    AppRoutesName.interestRateScreen: (_) => const InterestRateScreen(),
    AppRoutesName.beneficiaryDirectoryScreen: (_) => BlocProvider(
          create: (_) => getIt<BeneficiaryCubit>(),
          child: const BeneficiaryDirectoryScreen(),
        ),
    AppRoutesName.addBeneficiaryScreen: (context) {
      final arguments = ModalRoute.of(context)?.settings.arguments;
      if (arguments is BeneficiaryCubit) {
        return BlocProvider.value(
          value: arguments,
          child: const AddBeneficiaryScreen(),
        );
      }
      return BlocProvider(
        create: (_) => getIt<BeneficiaryCubit>(),
        child: const AddBeneficiaryScreen(),
      );
    },
    AppRoutesName.beneficiaryDetailScreen: (context) {
      final arguments = ModalRoute.of(context)?.settings.arguments;
      if (arguments is Map<String, dynamic>) {
        final cubit = arguments['cubit'] as BeneficiaryCubit;
        final beneficiary = arguments['beneficiary'] as Beneficiary;
        return BlocProvider.value(
          value: cubit,
          child: BeneficiaryDetailScreen(beneficiary: beneficiary),
        );
      }
      throw Exception('Invalid arguments for BeneficiaryDetailScreen');
    },
  };
}
