import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_pay_app/core/constants/api_constants.dart';
import 'package:easy_pay_app/core/errors/failures.dart';
import '../../domain/entities/transaction_report_entity.dart';
import '../../domain/repositories/transaction_report_repository.dart';
import '../datasources/transaction_report_remote_data_source.dart';

class TransactionReportRepositoryImpl implements TransactionReportRepository {
  final TransactionReportRemoteDataSource remoteDataSource;

  TransactionReportRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, TransactionReportEntity>> getMonthlyReport() async {
    try {
      final model = await remoteDataSource.getMonthlyReport();
      return Right(model.toEntity());
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data['message'] ?? e.message ?? ApiConstants.unknownError;
      return Left(ServerFailure(errorMessage));
    } catch (e) {
      final msg = e.toString().replaceAll('Exception: ', '');
      return Left(ServerFailure(msg));
    }
  }
}
