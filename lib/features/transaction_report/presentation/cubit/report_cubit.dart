import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_monthly_report_usecase.dart';
import 'report_state.dart';

class ReportCubit extends Cubit<ReportState> {
  final GetMonthlyReportUseCase getMonthlyReportUseCase;

  ReportCubit({required this.getMonthlyReportUseCase}) : super(ReportInitial());

  Future<void> getMonthlyReport() async {
    emit(ReportLoading());
    final result = await getMonthlyReportUseCase();
    result.fold(
      (failure) => emit(ReportError(failure.message)),
      (report) => emit(ReportSuccess(report)),
    );
  }
}
