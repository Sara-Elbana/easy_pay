import '../entities/transfer_card.dart';
import '../entities/beneficiary.dart';

abstract class TransferRepository {
  Future<List<TransferCard>> getCards();
  Future<List<Beneficiary>> getBeneficiaries();
  Future<bool> executeTransfer({
    required String fromCardId,
    required String beneficiaryName,
    required String cardNumber,
    required double amount,
    required String content,
    required bool saveBeneficiary,
  });
}
