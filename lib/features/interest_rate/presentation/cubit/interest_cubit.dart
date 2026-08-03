import 'package:easy_pay_app/core/cubit/base_state.dart';
import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/interest_rate/domain/entities/interest_rate.dart';
import 'package:easy_pay_app/features/interest_rate/domain/usecases/get_interest_rates_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InterestCubit extends Cubit<BaseState<List<InterestRate>>> {
  final GetInterestRatesUseCase getInterestRatesUseCase;

  InterestCubit({required this.getInterestRatesUseCase})
      : super(const BaseInitial());

  Future<void> getInterestRates() async {
    emit(const BaseLoading());
    final result = await getInterestRatesUseCase();
    if (isClosed) return;
    if (result is ApiSuccess<List<InterestRate>>) {
      emit(BaseSuccess(result.data));
    } else if (result is ApiFailure<List<InterestRate>>) {
      emit(BaseError(result.error));
    }
  }
}