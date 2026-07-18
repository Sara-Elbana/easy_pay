import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/exchange_repository.dart';
import 'exchange_state.dart';

class ExchangeCubit extends Cubit<ExchangeState> {
  final ExchangeRepository repository;

  ExchangeCubit({required this.repository}) : super(const ExchangeState()) {
    updateConversionRate();
  }

  Future<void> updateConversionRate() async {
    try {
      final data = await repository.convertCurrency(
        from: state.fromCurrency,
        to: state.toCurrency,
        amount: 1.0,
      );
      final rate = (data['rate'] as num).toDouble();
      emit(state.copyWith(conversionRate: rate));
    } catch (_) {}
  }

  void changeFromCurrency(String currencyCode) async {
    emit(state.copyWith(fromCurrency: currencyCode, toAmount: ''));
    await updateConversionRate();
    if (state.fromAmount.isNotEmpty) {
      convertAmount(state.fromAmount);
    }
  }

  void changeToCurrency(String currencyCode) async {
    emit(state.copyWith(toCurrency: currencyCode, toAmount: ''));
    await updateConversionRate();
    if (state.fromAmount.isNotEmpty) {
      convertAmount(state.fromAmount);
    }
  }

  void swapCurrencies() async {
    final originalFrom = state.fromCurrency;
    final originalTo = state.toCurrency;
    final originalFromAmount = state.fromAmount;
    final originalToAmount = state.toAmount;

    emit(state.copyWith(
      fromCurrency: originalTo,
      toCurrency: originalFrom,
      fromAmount: originalToAmount,
      toAmount: originalFromAmount,
    ));

    await updateConversionRate();
  }

  Future<void> convertAmount(String amountStr) async {
    if (amountStr.isEmpty) {
      emit(state.copyWith(fromAmount: '', toAmount: ''));
      return;
    }

    final amount = double.tryParse(amountStr);
    if (amount == null || amount <= 0) {
      emit(state.copyWith(fromAmount: amountStr, toAmount: ''));
      return;
    }

    emit(state.copyWith(fromAmount: amountStr, isLoading: true));

    try {
      final resultData = await repository.convertCurrency(
        from: state.fromCurrency,
        to: state.toCurrency,
        amount: amount,
      );

      final result = resultData['result'];
      final rate = resultData['rate'];

      emit(state.copyWith(
        toAmount: result != null ? (result as num).toStringAsFixed(2) : '',
        conversionRate: rate != null ? (rate as num).toDouble() : state.conversionRate,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        errorMessage: e.toString(),
        isLoading: false,
      ));
    }
  }

  void executeExchange() async {
    if (state.fromAmount.isEmpty) return;
    emit(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(milliseconds: 1000));
    emit(state.copyWith(isLoading: false, isExchangeSuccess: true));
  }

  void resetSuccess() {
    emit(state.copyWith(isExchangeSuccess: false));
  }
}
