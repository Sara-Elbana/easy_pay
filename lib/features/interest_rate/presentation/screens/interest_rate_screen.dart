import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/widgets/custom_app_bar.dart';
import 'package:easy_pay_app/features/exchange_rate/presentation/widgets/exchange_rate_header.dart';
import 'package:easy_pay_app/features/interest_rate/domain/entities/interest_rate.dart';
import 'package:easy_pay_app/features/interest_rate/domain/repositories/interest_repository.dart';
import 'package:flutter/material.dart';

class InterestRateScreen extends StatelessWidget {
  const InterestRateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:  CustomAppBar(title: "interest_rate".tr()),
      body: FutureBuilder<List<InterestRate>>(
        future: InterestRemoteDataSource().getInterestRates(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final data = snapshot.data!;
          return Column(
            children: [
              const ExchangeRateHeader(
                title1: "interest_kind",
                title2: "deposit",
                title3: "rate",
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: data.length,
                  separatorBuilder: (_, __) => const Divider(color: Color(0xFFF5F5F5)),
                  itemBuilder: (context, index) {
                    final item = data[index];
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Row(
                        children: [
                          Expanded(flex: 5, child: Text(item.kind, style: const TextStyle(fontWeight: FontWeight.w500))),
                          Expanded(flex: 2, child: Text(item.deposit, textAlign: TextAlign.right, style: const TextStyle(color: AppColors.black))),
                          Expanded(flex: 2, child: Text(item.rate, textAlign: TextAlign.right, style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold))),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}