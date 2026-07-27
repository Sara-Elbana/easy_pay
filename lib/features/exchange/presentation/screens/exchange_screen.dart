import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/constants/app_assets.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/widgets/custom_app_bar.dart';
import 'package:easy_pay_app/core/widgets/custom_currency_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/exchange_cubit.dart';
import '../cubit/exchange_state.dart';
import '../widgets/currency_input_field.dart';
import '../widgets/swap_button.dart';
import 'package:easy_pay_app/core/theme/app_text_styles.dart';

class ExchangeScreen extends StatelessWidget {
  const ExchangeScreen({super.key});

  static const List<CurrencyInfo> _supportedCurrencies = [
    CurrencyInfo(code: 'USD', symbol: '\$', name: 'Dollar'),
    CurrencyInfo(code: 'EUR', symbol: '€', name: 'Euro'),
    CurrencyInfo(code: 'GBP', symbol: '£', name: 'British Pound'),
    CurrencyInfo(code: 'EGP', symbol: 'E.£', name: 'Egyptian Pound'),
    CurrencyInfo(code: 'SAR', symbol: 'SR', name: 'Saudi Riyal'),
    CurrencyInfo(code: 'AED', symbol: 'AED', name: 'UAE Dirham'),
  ];

  void _showCurrencyDialog(
    BuildContext context,
    String selectedCurrencyCode,
    ValueChanged<String> onSelected,
  ) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withAlpha(50),
      builder: (dialogContext) {
        return CustomCurrencyDialog(
          currencies: _supportedCurrencies,
          selectedCurrencyCode: selectedCurrencyCode,
          onCurrencySelected: (currency) {
            onSelected(currency.code);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExchangeCubit, ExchangeState>(
      listener: (context, state) {
        if (state.isExchangeSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'exchange_success'.tr(),
                style: AppTextStyles.bodyMediumPoppins,
              ),
              backgroundColor: AppColors.primary,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
          context.read<ExchangeCubit>().resetSuccess();
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: 'exchange'.tr(),
          centerTitle: false,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  AppAssets.exchangeIllus,
                  height: 210,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 24),
                BlocBuilder<ExchangeCubit, ExchangeState>(
                  builder: (context, state) {
                    final cubit = context.read<ExchangeCubit>();
                    final bool isButtonEnabled =
                        state.fromAmount.isNotEmpty && !state.isLoading;

                    return Container(
                      padding: const EdgeInsets.all(24.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: const [
                          BoxShadow(
                            color: AppColors.primary,
                            blurRadius: 30,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CurrencyInputField(
                            label: 'from'.tr(),
                            selectedCurrency: state.fromCurrency,
                            amount: state.fromAmount,
                            onAmountChanged: (val) => cubit.convertAmount(val),
                            onCurrencyTap: () => _showCurrencyDialog(
                              context,
                              state.fromCurrency,
                              (code) => cubit.changeFromCurrency(code),
                            ),
                          ),
                          SwapButton(
                            onTap: () => cubit.swapCurrencies(),
                          ),
                          CurrencyInputField(
                            label: 'to'.tr(),
                            selectedCurrency: state.toCurrency,
                            amount: state.toAmount,
                            readOnly: true,
                            onCurrencyTap: () => _showCurrencyDialog(
                              context,
                              state.toCurrency,
                              (code) => cubit.changeToCurrency(code),
                            ),
                          ),
                          if (state.fromAmount.isNotEmpty &&
                              state.conversionRate > 0) ...[
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'currency_rate'.tr(),
                                  style: AppTextStyles.labelLargePrimary,
                                ),
                                Text(
                                  '1 ${state.fromCurrency} = ${state.conversionRate.toStringAsFixed(4)} ${state.toCurrency}',
                                  style: AppTextStyles.labelLargeGray,
                                ),
                              ],
                            ),
                          ],
                          const SizedBox(height: 32),
                          ElevatedButton(
                            onPressed: isButtonEnabled
                                ? () => cubit.executeExchange()
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isButtonEnabled
                                  ? AppColors.primary
                                  : AppColors.chatBgColor,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: state.isLoading
                                ? const SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    'exchange'.tr(),
                                    style: AppTextStyles.bodyLargeSemiBold.copyWith(color: isButtonEnabled ? Colors.white : AppColors.textLight, fontFamily: 'Poppins'),
                                  ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}