import 'package:easy_pay_app/features/interest_rate/domain/usecases/get_interest_rates_usecase.dart';
import 'package:easy_pay_app/features/interest_rate/presentation/cubit/interest_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InterestCubit extends Cubit<InterestState> {
  final GetInterestRatesUseCase getInterestRatesUseCase;

  InterestCubit({required this.getInterestRatesUseCase})
      : super(const InterestInitial());

  Future<void> getInterestRates() async {
    emit(const InterestLoading());
    try {
      final rates = await getInterestRatesUseCase();
      emit(InterestSuccess(rates));
    } catch (e) {
      emit(InterestFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }
}
