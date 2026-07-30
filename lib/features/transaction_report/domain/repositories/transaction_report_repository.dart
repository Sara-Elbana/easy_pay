import 'package:easy_pay_app/core/network/api_result.dart';
import '../entities/transaction_report_entity.dart';

abstract class TransactionReportRepository {
  Future<ApiResult<TransactionReportEntity>> getMonthlyReport();
}
