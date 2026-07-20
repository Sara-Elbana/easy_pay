import '../entities/transfer_card.dart';

abstract class TransferRepository {
  Future<List<TransferCard>> getCards();
  Future<bool> executeTransfer({
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
