import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/exchange_rate/domain/entities/exchange_rate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/exchange_rate_repository.dart';
import 'exchange_rate_state.dart';

class ExchangeRateCubit extends Cubit<ExchangeRateState> {
  final ExchangeRateRepository repository;

  ExchangeRateCubit({required this.repository}) : super(const ExchangeRateInitial());

  Future<void> getExchangeRates() async {
    emit(const ExchangeRateLoading());
    final result = await repository.getLiveExchangeRates();
    if (result is ApiSuccess<List<ExchangeRate>>) {
      emit(ExchangeRateLoaded(exchangeRates: result.data));
    } else if (result is ApiFailure<List<ExchangeRate>>) {
      emit(ExchangeRateError(message: result.error));
    }
  }
}
