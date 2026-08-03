import 'package:easy_pay_app/core/widgets/account_card_selector.dart';
import 'package:easy_pay_app/features/transfer/domain/entities/transfer_card.dart';
import 'package:flutter/material.dart';

class AccountDropdown extends StatelessWidget {
  final List<TransferCard>? cards;
  final TransferCard? selectedCard;
  final ValueChanged<TransferCard?>? onChanged;

  const AccountDropdown({
    super.key,
    this.cards,
    this.selectedCard,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return const AccountCardSelector();
  }
}
