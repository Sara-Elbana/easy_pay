import 'package:easy_pay_app/core/network/api_result.dart';
import '../entities/transaction_report_entity.dart';
import '../repositories/transaction_report_repository.dart';

class GetMonthlyReportUseCase {
  final TransactionReportRepository repository;

  GetMonthlyReportUseCase(this.repository);

  Future<ApiResult<TransactionReportEntity>> call() async {
    return await repository.getMonthlyReport();
  }
}
