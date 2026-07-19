import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/routes/app_routes_name.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/widgets/custom_app_bar.dart';
import 'package:easy_pay_app/core/widgets/custom_button.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:easy_pay_app/features/message/domain/use_cases/get_accounts_use_case.dart';
import 'package:easy_pay_app/features/message/presentation/cubit/account_cubit.dart';
import 'package:easy_pay_app/features/message/presentation/cubit/account_state.dart';
import 'package:easy_pay_app/features/message/presentation/widgets/account_card_item.dart';
import 'package:easy_pay_app/features/message/presentation/widgets/profile_header.dart';
import 'package:easy_pay_app/features/message/presentation/widgets/toggle_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_pay_app/core/constants/app_assets.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  int _currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AccountCubit(getAccountsUseCase: GetAccountsUseCase())
            ..loadAccounts(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: CustomAppBar(
          title: "account_and_card".tr(),
        ),
        body: Column(
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
            if (_currentTab == 0) ...[
              const ProfileHeader(),
              SizedBox(height: context.scaleHeight(24)),
            ],
            Expanded(
              child: _currentTab == 0 ? _buildAccountTab() : _buildCardTab(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountTab() {
    return BlocBuilder<AccountCubit, AccountState>(
      builder: (context, state) {
        if (state is AccountLoading) {
          return const Center(
              child: CircularProgressIndicator(color: AppColors.primary));
        } else if (state is AccountSuccess) {
          return ListView.builder(
            itemCount: state.accounts.length,
            itemBuilder: (context, index) {
              return AccountCardItem(account: state.accounts[index]);
            },
          );
        } else if (state is AccountError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildCardTab(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(context.scaleWidth(24)),
          child: Image.asset(
            AppAssets.bankCardBlue,
            fit: BoxFit.cover,
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(context.scaleWidth(24)),
          child: Image.asset(
            AppAssets.bankCardYellow,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(context.scaleWidth(24)),
          child: CustomButton(
            text: 'add_card'.tr(),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutesName.cardDetailsScreen);
            },
          ),
        ),
      ],
    );
  }
}
