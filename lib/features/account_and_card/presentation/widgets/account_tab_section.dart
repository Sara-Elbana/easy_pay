import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/features/account_and_card/domain/entities/account_entity.dart';
import 'package:easy_pay_app/features/account_and_card/presentation/widgets/account_card_item.dart';
import 'package:flutter/material.dart';

class AccountTabSection extends StatelessWidget {
  final List<AccountEntity> accounts;

  const AccountTabSection({super.key, required this.accounts});

  @override
  Widget build(BuildContext context) {
    if (accounts.isEmpty) {
      return Center(child: Text("no_accounts_found".tr()));
    }

    return ListView.builder(
      itemCount: accounts.length,
      itemBuilder: (context, index) {
        return AccountCardItem(account: accounts[index]);
      },
    );
  }
}