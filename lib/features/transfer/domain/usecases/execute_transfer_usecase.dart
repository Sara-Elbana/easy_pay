import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/transfer/data/models/requests/transfer_request.dart';
import '../repositories/transfer_repository.dart';

class ExecuteTransferUseCase {
  final TransferRepository repository;

  ExecuteTransferUseCase(this.repository);

  Future<ApiResult<bool>> call(TransferRequest request) async {
    return await repository.executeTransfer(request);
  }
}
