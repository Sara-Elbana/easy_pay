import 'package:easy_pay_app/core/widgets/account_card_selector.dart';
import 'package:flutter/material.dart';

class WithdrawCardDropdown extends StatelessWidget {
  final ValueChanged<dynamic>? onSelectionChanged;

  const WithdrawCardDropdown({super.key, this.onSelectionChanged});

  @override
  Widget build(BuildContext context) {
    return AccountCardSelector(
      onSelectionChanged: onSelectionChanged,
    );
  }
}
