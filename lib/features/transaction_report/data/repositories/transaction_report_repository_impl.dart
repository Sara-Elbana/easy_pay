import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/transaction_report/data/datasources/transaction_report_remote_data_source.dart';
import 'package:easy_pay_app/features/transaction_report/data/models/transaction_report_response_model.dart';
import 'package:easy_pay_app/features/transaction_report/domain/entities/transaction_report_entity.dart';
import 'package:easy_pay_app/features/transaction_report/domain/repositories/transaction_report_repository.dart';

class TransactionReportRepositoryImpl implements TransactionReportRepository {
  final TransactionReportRemoteDataSource remoteDataSource;

  TransactionReportRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<ApiResult<TransactionReportEntity>> getMonthlyReport() async {
    final result = await remoteDataSource.getMonthlyReport();

    if (result is ApiSuccess<TransactionReportResponseModel>) {
      return ApiSuccess(
        data: result.data.toEntity(),
        message: result.message,
      );
    }

    final failure = result as ApiFailure<TransactionReportResponseModel>;

    return ApiFailure(
      error: failure.error,
      message: failure.message,
    );
  }
}
