import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/cubit/base_state.dart';
import 'package:easy_pay_app/core/di/service_locator.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/theme/app_text_styles.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:easy_pay_app/core/widgets/custom_loading_widget.dart';
import 'package:easy_pay_app/features/account_and_card/domain/entities/account_entity.dart';
import 'package:easy_pay_app/features/account_and_card/domain/entities/card_entity.dart';
import 'package:easy_pay_app/features/account_and_card/presentation/cubit/account_cubit.dart';
import 'package:easy_pay_app/features/account_and_card/presentation/cubit/card_cubit.dart';
import 'package:easy_pay_app/features/account_and_card/presentation/widgets/toggle_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountCardSelector extends StatefulWidget {
  final ValueChanged<dynamic>? onSelectionChanged;
  final dynamic initialSelection;

  const AccountCardSelector({
    super.key,
    this.onSelectionChanged,
    this.initialSelection,
  });

  @override
  State<AccountCardSelector> createState() => _AccountCardSelectorState();
}

class _AccountCardSelectorState extends State<AccountCardSelector> {
  int _selectedTab = 0; // 0 = Account, 1 = Card
  dynamic _selectedItem;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.initialSelection;
    getIt<AccountCubit>().loadAccounts();
    getIt<CardCubit>().loadCards();
  }

  void _onTabChanged(int index) {
    if (_selectedTab != index) {
      setState(() {
        _selectedTab = index;
        _selectedItem = null;
      });
      if (widget.onSelectionChanged != null) {
        widget.onSelectionChanged!(null);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ToggleTabs(
          selectedIndex: _selectedTab,
          onTabChanged: _onTabChanged,
        ),
        SizedBox(height: context.scaleHeight(16)),
        _selectedTab == 0 ? _buildAccountDropdown(context) : _buildCardDropdown(context),
      ],
    );
  }

  Widget _buildAccountDropdown(BuildContext context) {
    return BlocBuilder<AccountCubit, BaseState<List<AccountEntity>>>(
      bloc: getIt<AccountCubit>(),
      builder: (context, state) {
        if (state is BaseLoading) {
          return const CustomLoadingWidget();
        }

        List<AccountEntity> accounts = [];
        if (state is BaseSuccess<List<AccountEntity>>) {
          accounts = state.data;
        }

        final selectedAccount = _selectedItem is AccountEntity ? _selectedItem as AccountEntity : null;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.inputBorder,
                  width: 1.5,
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: context.scaleWidth(16)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<AccountEntity>(
                  value: accounts.contains(selectedAccount) ? selectedAccount : null,
                  hint: Text(
                    'choose_account'.tr(),
                    style: AppTextStyles.titleMediumSmallLight,
                  ),
                  isExpanded: true,
                  icon: const Icon(
                    Icons.unfold_more,
                    color: AppColors.textLight,
                    size: 20,
                  ),
                  onChanged: (acc) {
                    setState(() {
                      _selectedItem = acc;
                    });
                    if (widget.onSelectionChanged != null) {
                      widget.onSelectionChanged!(acc);
                    }
                  },
                  items: accounts.map((acc) {
                    return DropdownMenuItem<AccountEntity>(
                      value: acc,
                      child: Text(
                        acc.accountNumber,
                        style: AppTextStyles.titleMediumSmallDark,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            if (selectedAccount != null) ...[
              SizedBox(height: context.scaleHeight(8)),
              Text(
                'Available balance: \$${selectedAccount.balance}',
                style: AppTextStyles.bodyMediumPrimary,
              ),
            ],
          ],
        );
      },
    );
  }

  Widget _buildCardDropdown(BuildContext context) {
    return BlocBuilder<CardCubit, BaseState<List<CardEntity>>>(
      bloc: getIt<CardCubit>(),
      builder: (context, state) {
        if (state is BaseLoading) {
          return const CustomLoadingWidget();
        }

        List<CardEntity> cards = [];
        if (state is BaseSuccess<List<CardEntity>>) {
          cards = state.data;
        }

        final selectedCard = _selectedItem is CardEntity ? _selectedItem as CardEntity : null;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.inputBorder,
                  width: 1.5,
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: context.scaleWidth(16)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<CardEntity>(
                  value: cards.contains(selectedCard) ? selectedCard : null,
                  hint: Text(
                    'choose_card'.tr(),
                    style: AppTextStyles.titleMediumSmallLight,
                  ),
                  isExpanded: true,
                  icon: const Icon(
                    Icons.unfold_more,
                    color: AppColors.textLight,
                    size: 20,
                  ),
                  onChanged: (card) {
                    setState(() {
                      _selectedItem = card;
                    });
                    if (widget.onSelectionChanged != null) {
                      widget.onSelectionChanged!(card);
                    }
                  },
                  items: cards.map((card) {
                    final displayNum = card.maskedCardNumber.isNotEmpty
                        ? card.maskedCardNumber
                        : card.cardNumber;
                    return DropdownMenuItem<CardEntity>(
                      value: card,
                      child: Text(
                        displayNum,
                        style: AppTextStyles.titleMediumSmallDark,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            if (selectedCard != null) ...[
              SizedBox(height: context.scaleHeight(8)),
              Text(
                'Available balance: \$${selectedCard.bankAccount.balance}',
                style: AppTextStyles.bodyMediumPrimary,
              ),
            ],
          ],
        );
      },
    );
  }
}
