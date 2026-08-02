import 'package:easy_pay_app/core/cubit/base_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_pay_app/core/network/api_result.dart';
import '../../domain/entities/transaction_report_entity.dart';
import '../../domain/usecases/get_monthly_report_usecase.dart';

class ReportCubit extends Cubit<BaseState<TransactionReportEntity>> {
  final GetMonthlyReportUseCase getMonthlyReportUseCase;

  ReportCubit({required this.getMonthlyReportUseCase}) : super(const BaseInitial());

  Future<void> getMonthlyReport() async {
    emit(const BaseLoading());
    final result = await getMonthlyReportUseCase();
    if (isClosed) return;
    if (result is ApiSuccess<TransactionReportEntity>) {
      emit(BaseSuccess(result.data));
    } else if (result is ApiFailure<TransactionReportEntity>) {
      emit(BaseError(result.error));
    }
  }
}
