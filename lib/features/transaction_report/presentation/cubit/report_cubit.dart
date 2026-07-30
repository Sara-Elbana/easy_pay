import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_pay_app/core/network/api_result.dart';
import '../../domain/entities/transaction_report_entity.dart';
import '../../domain/usecases/get_monthly_report_usecase.dart';
import 'report_state.dart';

class ReportCubit extends Cubit<ReportState> {
  final GetMonthlyReportUseCase getMonthlyReportUseCase;

  ReportCubit({required this.getMonthlyReportUseCase}) : super(ReportInitial());

  Future<void> getMonthlyReport() async {
    emit(ReportLoading());
    final result = await getMonthlyReportUseCase();
    if (result is ApiSuccess<TransactionReportEntity>) {
      emit(ReportSuccess(result.data));
    } else if (result is ApiFailure<TransactionReportEntity>) {
      emit(ReportError(result.error));
    }
  }
}
