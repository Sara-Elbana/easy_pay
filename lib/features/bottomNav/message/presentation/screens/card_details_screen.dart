import 'package:easy_pay_app/features/bottomNav/message/presentation/widgets/card_info_row.dart';
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
        title: const Text(
          'Card',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          const CardInfoRow(label: 'Name', value: 'Sara Refaat'),
          const CardInfoRow(label: 'Card number', value: '**** **** 9018'),
          const CardInfoRow(label: 'Valid from', value: '10/15'),
          const CardInfoRow(label: 'Good thru', value: '10/20'),
          const CardInfoRow(label: 'Available balance', value: '\$10,000'),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 40.0),
            child: TextButton(
              onPressed: () {},
              child: const Text(
                'Delete card',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 16,
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
