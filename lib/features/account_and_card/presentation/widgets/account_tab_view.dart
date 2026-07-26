import 'package:easy_pay_app/features/account_and_card/domain/entities/account_entity.dart';
import 'package:flutter/material.dart';
import 'package:easy_pay_app/features/account_and_card/presentation/widgets/account_card_item.dart';

class AccountTabView extends StatelessWidget {
  final List<AccountEntity>accounts;

  const AccountTabView({super.key, required this.accounts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: accounts.length,
      itemBuilder: (context, index) {
        return AccountCardItem(account: accounts[index]);
      },
    );
  }
}