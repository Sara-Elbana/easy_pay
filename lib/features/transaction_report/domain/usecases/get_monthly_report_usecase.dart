import 'package:dartz/dartz.dart';
import 'package:easy_pay_app/core/errors/failures.dart';
import '../entities/transaction_report_entity.dart';
import '../repositories/transaction_report_repository.dart';

class GetMonthlyReportUseCase {
  final TransactionReportRepository repository;

  GetMonthlyReportUseCase(this.repository);

  Future<Either<Failure, TransactionReportEntity>> call() async {
    return await repository.getMonthlyReport();
  }
}
