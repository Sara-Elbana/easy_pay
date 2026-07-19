import 'package:equatable/equatable.dart';
import '../../domain/entities/exchange_rate.dart';

abstract class ExchangeRateState extends Equatable {
  const ExchangeRateState();

  @override
  List<Object?> get props => [];
}

class ExchangeRateInitial extends ExchangeRateState {
  const ExchangeRateInitial();
}

class ExchangeRateLoading extends ExchangeRateState {
  const ExchangeRateLoading();
}

class ExchangeRateLoaded extends ExchangeRateState {
  final List<ExchangeRate> exchangeRates;

  const ExchangeRateLoaded({required this.exchangeRates});

  @override
  List<Object?> get props => [exchangeRates];
}

class ExchangeRateError extends ExchangeRateState {
  final String message;

  const ExchangeRateError({required this.message});

  @override
  List<Object?> get props => [message];
}
