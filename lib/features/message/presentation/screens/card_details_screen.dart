import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/features/message/presentation/widgets/card_info_row.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';

class CardDetailsScreen extends StatelessWidget {
  const CardDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'card'.tr(),
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: context.scaleWidth(20),
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          SizedBox(height: context.scaleHeight(16)),
          CardInfoRow(label: 'name'.tr(), value: 'Sara Refaat'),
          CardInfoRow(label: 'card_number'.tr(), value: '**** **** 9018'),
          CardInfoRow(label: 'valid_from'.tr(), value: '10/15'),
          CardInfoRow(label: 'good_thru'.tr(), value: '10/20'),
          CardInfoRow(label: 'available_balance'.tr(), value: '\$10,000'),
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(bottom: context.scaleHeight(40.0)),
            child: TextButton(
              onPressed: () {},
              child: Text(
                'delete_card'.tr(),
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: context.scaleWidth(16),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
