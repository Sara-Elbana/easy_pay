import 'package:easy_pay_app/core/network/api_result.dart';
import '../entities/transfer_card.dart';

abstract class TransferRepository {
  Future<ApiResult<List<TransferCard>>> getCards();
  Future<ApiResult<bool>> executeTransfer({
    required String fromCardId,
    required String beneficiaryName,
    required String cardNumber,
    required double amount,
    required String content,
    required bool saveBeneficiary,
    int? type,
    String? bank,
    String? branch,
  });
}
