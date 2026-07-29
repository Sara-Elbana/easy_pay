import 'package:dartz/dartz.dart';
import 'package:easy_pay_app/core/errors/failures.dart';
import '../entities/transaction_report_entity.dart';

abstract class TransactionReportRepository {
  Future<Either<Failure, TransactionReportEntity>> getMonthlyReport();
}
