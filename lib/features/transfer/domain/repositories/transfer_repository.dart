import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/transfer/data/models/requests/transfer_request.dart';
import '../entities/transfer_card.dart';

abstract class TransferRepository {
  Future<ApiResult<List<TransferCard>>> getCards();
  Future<ApiResult<bool>> executeTransfer(TransferRequest request);
}
