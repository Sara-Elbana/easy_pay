import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';

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
                children: [
                  OnboardingPageContent(
                    imagePath: 'assets/images/onboarding_balance.png',
                    title: "send_money_to_the_other_party_easily".tr(),
                    description:
                        "say_goodbye_to_costly_fees_and_complicated_processes_lets_get_started_on_simplifying_your_international_transactions"
                            .tr(),
                  ),
                  OnboardingPageContent(
                    imagePath: 'assets/images/onboarding_success.png',
                    title: "safe_and_fast_transactions".tr(),
                    description:
                        "your_financial_data_is_encrypted_and_securely_protected_ensuring_your_money_is_always_safe"
                            .tr(),
                  ),
                  OnboardingPageContent(
                    imagePath: 'assets/images/onboarding_cards.png',
                    title: "manage_your_money_in_one_place".tr(),
                    description:
                        "track_balances_transfer_money_pay_bills_and_manage_all_your_finances_easily"
                            .tr(),
                  ),
                ],
              ),
            ),
            SizedBox(height: context.scaleHeight(8)),
            OnboardingIndicator(
              pageIndex: state.pageIndex,
              totalPages: _totalPages,
            ),
            SizedBox(height: context.scaleHeight(28)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.padHigh),
              child: OnboardingNavButtons(
                pageIndex: state.pageIndex,
                totalPages: _totalPages,
                onSkip: cubit.skip,
                onNext: cubit.nextPage,
                onGetStarted: cubit.finishOnboarding,
              ),
            ),
            SizedBox(height: context.scaleHeight(28)),
          ],
        );
      },
    );
  }
}
