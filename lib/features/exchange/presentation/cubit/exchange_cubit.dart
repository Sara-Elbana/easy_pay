import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/requests/convert_currency_request.dart';
import '../../domain/repositories/exchange_repository.dart';
import 'exchange_state.dart';

class ExchangeCubit extends Cubit<ExchangeState> {
  final ExchangeRepository repository;

  ExchangeCubit({required this.repository}) : super(const ExchangeState()) {
    updateConversionRate();
  }

  Future<void> updateConversionRate() async {
    final request = ConvertCurrencyRequest(
      from: state.fromCurrency,
      to: state.toCurrency,
      amount: 1.0,
    );
    final result = await repository.convertCurrency(request);
    if (result is ApiSuccess<Map<String, dynamic>>) {
      final rate = (result.data['rate'] as num).toDouble();
      emit(state.copyWith(conversionRate: rate));
    }
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

    final request = ConvertCurrencyRequest(
      from: state.fromCurrency,
      to: state.toCurrency,
      amount: amount,
    );
    final resultData = await repository.convertCurrency(request);

    if (resultData is ApiSuccess<Map<String, dynamic>>) {
      final result = resultData.data['result'];
      final rate = resultData.data['rate'];

      emit(state.copyWith(
        toAmount: result != null ? (result as num).toStringAsFixed(2) : '',
        conversionRate: rate != null ? (rate as num).toDouble() : state.conversionRate,
        isLoading: false,
      ));
    } else if (resultData is ApiFailure<Map<String, dynamic>>) {
      emit(state.copyWith(
        errorMessage: resultData.error,
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