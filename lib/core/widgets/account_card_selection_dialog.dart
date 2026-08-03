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
import 'package:easy_pay_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';

class SelectionItem {
  final String id;
  final String title; // User Name
  final String subtitle; // Account Number or Masked Card Number
  final String? balance;
  final dynamic rawData;

  const SelectionItem({
    required this.id,
    required this.title,
    required this.subtitle,
    this.balance,
    this.rawData,
  });
}

class AccountCardSelectionDialog extends StatelessWidget {
  final bool isAccount; // true = Account, false = Card
  final SelectionItem? selectedItem;
  final ValueChanged<SelectionItem> onSelected;

  const AccountCardSelectionDialog({
    super.key,
    required this.isAccount,
    this.selectedItem,
    required this.onSelected,
  });

  static Future<void> show({
    required BuildContext context,
    required bool isAccount,
    SelectionItem? selectedItem,
    required ValueChanged<SelectionItem> onSelected,
  }) async {
    if (isAccount) {
      await getIt<AccountCubit>().loadAccounts();
    } else {
      await getIt<CardCubit>().loadCards();
    }

    if (!context.mounted) return;

    return showDialog(
      context: context,
      builder: (dialogContext) => AccountCardSelectionDialog(
        isAccount: isAccount,
        selectedItem: selectedItem,
        onSelected: (item) {
          Navigator.of(dialogContext).pop();
          onSelected(item);
        },
      ),
    );
  }

  String _getUserName() {
    final profileState = getIt<ProfileCubit>().state;
    if (profileState is BaseSuccess) {
      return (profileState as BaseSuccess).data.name;
    }
    return 'User';
  }

  @override
  Widget build(BuildContext context) {
    final title = isAccount ? 'choose_account'.tr() : 'choose_card'.tr();

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      backgroundColor: Colors.white,
      child: Container(
        padding: EdgeInsets.all(context.scaleWidth(20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: AppTextStyles.titleMediumDark.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: context.scaleWidth(18),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: AppColors.textLight),
                  onPressed: () => Navigator.pop(context),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            SizedBox(height: context.scaleHeight(16)),
            Flexible(
              child: isAccount ? _buildAccountList(context) : _buildCardList(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountList(BuildContext context) {
    final accountCubit = getIt<AccountCubit>();
    final accountState = accountCubit.state;
    final userName = _getUserName();

    if (accountState is BaseLoading) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: context.scaleHeight(24)),
        child: const CustomLoadingWidget(),
      );
    }

    if (accountState is BaseError) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: context.scaleHeight(16)),
        child: Center(
          child: Text(
            (accountState as BaseError).message,
            style: AppTextStyles.bodyMediumError,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (accountState is BaseSuccess<List<AccountEntity>>) {
      final accounts = accountState.data;
      if (accounts.isEmpty) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: context.scaleHeight(24)),
          child: Center(
            child: Text(
              'no_data'.tr(),
              style: AppTextStyles.bodyMediumGray,
            ),
          ),
        );
      }

      final items = accounts.map((acc) {
        final holderName = acc.bankCards.isNotEmpty
            ? acc.bankCards.first.cardHolderName
            : userName;
        return SelectionItem(
          id: 'acc_${acc.id}',
          title: holderName,
          subtitle: acc.accountNumber,
          balance: acc.balance,
          rawData: acc,
        );
      }).toList();

      return _buildItemsListView(context, items);
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.scaleHeight(24)),
      child: const CustomLoadingWidget(),
    );
  }

  Widget _buildCardList(BuildContext context) {
    final cardCubit = getIt<CardCubit>();
    final cardState = cardCubit.state;

    if (cardState is BaseLoading) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: context.scaleHeight(24)),
        child: const CustomLoadingWidget(),
      );
    }

    if (cardState is BaseError) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: context.scaleHeight(16)),
        child: Center(
          child: Text(
            (cardState as BaseError).message,
            style: AppTextStyles.bodyMediumError,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (cardState is BaseSuccess<List<CardEntity>>) {
      final cards = cardState.data;
      if (cards.isEmpty) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: context.scaleHeight(24)),
          child: Center(
            child: Text(
              'no_data'.tr(),
              style: AppTextStyles.bodyMediumGray,
            ),
          ),
        );
      }

      final items = cards.map((card) {
        return SelectionItem(
          id: 'card_${card.id}',
          title: card.cardHolderName,
          subtitle: card.maskedCardNumber,
          balance: card.bankAccount.balance,
          rawData: card,
        );
      }).toList();

      return _buildItemsListView(context, items);
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.scaleHeight(24)),
      child: const CustomLoadingWidget(),
    );
  }

  Widget _buildItemsListView(BuildContext context, List<SelectionItem> items) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: items.length,
      separatorBuilder: (_, __) => const Divider(
        color: AppColors.thinDivider,
        height: 1,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        final isSelected = selectedItem?.id == item.id;

        return ListTile(
          contentPadding: EdgeInsets.symmetric(
            vertical: context.scaleHeight(4),
            horizontal: context.scaleWidth(8),
          ),
          title: Text(
            item.title,
            style: AppTextStyles.bodyMediumDark.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            item.subtitle,
            style: AppTextStyles.bodySmallGray,
          ),
          trailing: isSelected
              ? const Icon(
                  Icons.check_circle,
                  color: AppColors.primary,
                )
              : null,
          onTap: () => onSelected(item),
        );
      },
    );
  }
}
