import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/exchange_rate_repository.dart';
import 'exchange_rate_state.dart';

class ExchangeRateCubit extends Cubit<ExchangeRateState> {
  final ExchangeRateRepository repository;

  ExchangeRateCubit({required this.repository}) : super(const ExchangeRateInitial());

  Future<void> getExchangeRates() async {
    emit(const ExchangeRateLoading());
    try {
      final rates = await repository.getLiveExchangeRates();
      emit(ExchangeRateLoaded(exchangeRates: rates));
    } catch (e) {
      emit(ExchangeRateError(message: e.toString()));
    }
  }
}
