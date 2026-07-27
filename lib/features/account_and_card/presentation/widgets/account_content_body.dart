import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/core.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:easy_pay_app/features/account_and_card/presentation/cubit/account_cubit.dart';
import 'package:easy_pay_app/features/account_and_card/presentation/cubit/account_state.dart';
import 'package:easy_pay_app/features/account_and_card/presentation/widgets/account_tab_section.dart';
import 'package:easy_pay_app/features/account_and_card/presentation/widgets/card_tab_section.dart';
import 'package:easy_pay_app/features/account_and_card/presentation/widgets/profile_header.dart';
import 'package:easy_pay_app/features/account_and_card/presentation/widgets/toggle_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountContentBody extends StatefulWidget {
  const AccountContentBody({super.key});

  @override
  State<AccountContentBody> createState() => _AccountContentBodyState();
}

class _AccountContentBodyState extends State<AccountContentBody> {
  int _currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: context.scaleHeight(16)),
        ToggleTabs(
          selectedIndex: _currentTab,
          onTabChanged: (index) {
            setState(() {
              _currentTab = index;
            });
          },
        ),
        SizedBox(height: context.scaleHeight(24)),
        Expanded(
          child: BlocBuilder<AccountCubit, AccountState>(
            builder: (context, state) {
              if (state is AccountLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                );
              } else if (state is AccountSuccess) {
                if (state.accounts.isEmpty) {
                  return Center(child: Text("no_accounts_found".tr()));
                }
                final holderName = state.accounts.first.bankCards.isNotEmpty
                    ? state.accounts.first.bankCards.first.cardHolderName
                    : "User";

                return Column(
                  children: [
                    if (_currentTab == 0) ...[
                      ProfileHeader(userName: holderName),
                      SizedBox(height: context.scaleHeight(24)),
                    ],
                    Expanded(
                      child: _currentTab == 0
                          ? AccountTabSection(accounts: state.accounts)
                          : const CardTabSection(),
                    ),
                  ],
                );
              } else if (state is AccountError) {
                return Center(
                  child: Text(
                    state.message,
                    style: AppTextStyles.bodyMediumRed,
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }
}