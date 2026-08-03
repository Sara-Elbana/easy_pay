import 'package:easy_pay_app/core/cubit/base_state.dart';
import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/exchange_rate/domain/entities/exchange_rate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/exchange_rate_repository.dart';

class ExchangeRateCubit extends Cubit<BaseState<List<ExchangeRate>>> {
  final ExchangeRateRepository repository;

  ExchangeRateCubit({required this.repository}) : super(const BaseInitial());

  Future<void> getExchangeRates() async {
    emit(const BaseLoading());
    final result = await repository.getLiveExchangeRates();
    if (isClosed) return;
    if (result is ApiSuccess<List<ExchangeRate>>) {
      emit(BaseSuccess(result.data));
    } else if (result is ApiFailure<List<ExchangeRate>>) {
      emit(BaseError(result.error));
    }
  }
}
