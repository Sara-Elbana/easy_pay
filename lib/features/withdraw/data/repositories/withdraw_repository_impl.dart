import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/withdraw/data/datasources/withdraw_remote_data_source.dart';
import 'package:easy_pay_app/features/withdraw/data/models/requests/withdraw_request.dart';
import '../../domain/repositories/withdraw_repository.dart';

class WithdrawRepositoryImpl implements WithdrawRepository {
  final WithdrawRemoteDataSource remoteDataSource;

  WithdrawRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ApiResult<bool>> executeWithdraw(WithdrawRequest request) async {
    return await remoteDataSource.executeWithdraw(request);
  }
}

