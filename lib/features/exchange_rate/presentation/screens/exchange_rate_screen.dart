import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/exchange_rate_cubit.dart';
import '../cubit/exchange_rate_state.dart';
import '../widgets/exchange_rate_header.dart';
import '../widgets/exchange_rate_row.dart';

class ExchangeRateScreen extends StatelessWidget {
  const ExchangeRateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'exchange_rate'.tr(),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const ExchangeRateHeader(
              title1: 'country',
              title2: 'buy',
              title3: 'sell',
            ),
            Expanded(
              child: BlocBuilder<ExchangeRateCubit, ExchangeRateState>(
                builder: (context, state) {
                  if (state is ExchangeRateLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    );
                  } else if (state is ExchangeRateError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'failed_to_load_rates'.tr(),
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () {
                              context.read<ExchangeRateCubit>().getExchangeRates();
                            },
                            child: Text('retry'.tr()),
                          ),
                        ],
                      ),
                    );
                  } else if (state is ExchangeRateLoaded) {
                    final rates = state.exchangeRates;
                    return ListView.separated(
                      itemCount: rates.length,
                      separatorBuilder: (context, index) => const Divider(
                        color: AppColors.gray200,
                        height: 1,
                        thickness: 0.5,
                        indent: 24,
                        endIndent: 24,
                      ),
                      itemBuilder: (context, index) {
                        final rate = rates[index];
                        return ExchangeRateRow(rate: rate);
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
