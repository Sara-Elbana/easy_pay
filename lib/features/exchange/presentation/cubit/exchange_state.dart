import 'package:equatable/equatable.dart';

class ExchangeState extends Equatable {
  final String fromCurrency;
  final String toCurrency;
  final String fromAmount;
  final String toAmount;
  final double conversionRate;
  final bool isLoading;
  final String? errorMessage;
  final bool isExchangeSuccess;

  const ExchangeState({
    this.fromCurrency = 'USD',
    this.toCurrency = 'EUR',
    this.fromAmount = '',
    this.toAmount = '',
    this.conversionRate = 0.0,
    this.isLoading = false,
    this.errorMessage,
    this.isExchangeSuccess = false,
  });

  ExchangeState copyWith({
    String? fromCurrency,
    String? toCurrency,
    String? fromAmount,
    String? toAmount,
    double? conversionRate,
    bool? isLoading,
    String? errorMessage,
    bool? isExchangeSuccess,
  }) {
    return ExchangeState(
      fromCurrency: fromCurrency ?? this.fromCurrency,
      toCurrency: toCurrency ?? this.toCurrency,
      fromAmount: fromAmount ?? this.fromAmount,
      toAmount: toAmount ?? this.toAmount,
      conversionRate: conversionRate ?? this.conversionRate,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isExchangeSuccess: isExchangeSuccess ?? this.isExchangeSuccess,
    );
  }

  @override
  List<Object?> get props => [
        fromCurrency,
        toCurrency,
        fromAmount,
        toAmount,
        conversionRate,
        isLoading,
        errorMessage,
        isExchangeSuccess,
      ];
}
