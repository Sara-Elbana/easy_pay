import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routes/app_routes_name.dart';
import '../cubit/onboarding_cubit.dart';
import '../cubit/onboarding_state.dart';
import '../widgets/onboarding_indicator.dart';
import '../widgets/onboarding_nav_buttons.dart';
import '../widgets/onboarding_page_content.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: OnboardingBody(),
      ),
    );
  }
}

class OnboardingBody extends StatefulWidget {
  const OnboardingBody({super.key});

  @override
  State<OnboardingBody> createState() => _OnboardingBodyState();
}

class _OnboardingBodyState extends State<OnboardingBody> {
  late final PageController _pageController;

  static const int _totalPages = 3;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardingCubit, OnboardingState>(
      listener: (context, state) {
        if (state.isFinished) {
          Navigator.pushReplacementNamed(
            context,
            AppRoutesName.welcomeScreen,
          );
        }

        if (_pageController.hasClients &&
            (_pageController.page?.round() ?? 0) != state.pageIndex) {
          _pageController.jumpToPage(state.pageIndex);
        }
      },
      builder: (context, state) {
        final cubit = context.read<OnboardingCubit>();

        return Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const BouncingScrollPhysics(),
                onPageChanged: cubit.setPage,
                children: const [
                  OnboardingPageContent(
                    imagePath: 'assets/images/onboarding_balance.png',
                    title: 'Send Money to the other party easily',
                    description:
                        "Say Goodbye to costly fees and complicated processes. Let's get started on simplifying your international transactions!",
                  ),
                  OnboardingPageContent(
                    imagePath: 'assets/images/onboarding_success.png',
                    title: 'Safe and Fast Transactions',
                    description:
                        'Your financial data is encrypted and securely protected, ensuring your money is always safe.',
                  ),
                  OnboardingPageContent(
                    imagePath: 'assets/images/onboarding_cards.png',
                    title: 'Manage your money in one place',
                    description:
                        'Track balances, transfer money, pay bills and manage all your finances easily.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            OnboardingIndicator(
              pageIndex: state.pageIndex,
              totalPages: _totalPages,
            ),
            const SizedBox(height: 28),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: OnboardingNavButtons(
                pageIndex: state.pageIndex,
                totalPages: _totalPages,
                onSkip: cubit.skip,
                onNext: cubit.nextPage,
                onGetStarted: cubit.finishOnboarding,
              ),
            ),
            const SizedBox(height: 28),
          ],
        );
      },
    );
  }
}
