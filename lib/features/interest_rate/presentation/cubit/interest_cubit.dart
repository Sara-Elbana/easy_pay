import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/interest_rate/domain/entities/interest_rate.dart';
import 'package:easy_pay_app/features/interest_rate/domain/usecases/get_interest_rates_usecase.dart';
import 'package:easy_pay_app/features/interest_rate/presentation/cubit/interest_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InterestCubit extends Cubit<InterestState> {
  final GetInterestRatesUseCase getInterestRatesUseCase;

  InterestCubit({required this.getInterestRatesUseCase})
      : super(const InterestInitial());

  Future<void> getInterestRates() async {
    emit(const InterestLoading());
    final result = await getInterestRatesUseCase();
    if (result is ApiSuccess<List<InterestRate>>) {
      emit(InterestSuccess(result.data));
    } else if (result is ApiFailure<List<InterestRate>>) {
      emit(InterestFailure(result.error));
    }
  }
}
