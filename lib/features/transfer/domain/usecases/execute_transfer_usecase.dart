import '../repositories/transfer_repository.dart';

class ExecuteTransferUseCase {
  final TransferRepository repository;

  ExecuteTransferUseCase(this.repository);

  Future<bool> call({
    required String fromCardId,
    required String beneficiaryName,
    required String cardNumber,
    required double amount,
    required String content,
    required bool saveBeneficiary,
    int? type,
    String? bank,
    String? branch,
  }) async {
    return await repository.executeTransfer(
      fromCardId: fromCardId,
      beneficiaryName: beneficiaryName,
      cardNumber: cardNumber,
      amount: amount,
      content: content,
      saveBeneficiary: saveBeneficiary,
      type: type,
      bank: bank,
      branch: branch,
    );
  }
}
