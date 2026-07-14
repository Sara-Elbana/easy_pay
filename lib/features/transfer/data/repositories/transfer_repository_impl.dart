import '../../domain/entities/beneficiary.dart';
import '../../domain/entities/transfer_card.dart';
import '../../domain/repositories/transfer_repository.dart';
import '../models/mock_transfer_data.dart';

class TransferRepositoryImpl implements TransferRepository {
  // Use mock lists from mock_transfer_data.dart
  final List<TransferCard> _mockCards = mockCards;
  final List<Beneficiary> _mockBeneficiaries = mockBeneficiaries;

  @override
  Future<List<TransferCard>> getCards() async {
    // Simulate API network delay
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockCards;
  }

  @override
  Future<List<Beneficiary>> getBeneficiaries() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockBeneficiaries;
  }

  @override
  Future<bool> executeTransfer({
    required String fromCardId,
    required String beneficiaryName,
    required String cardNumber,
    required double amount,
    required String content,
    required bool saveBeneficiary,
  }) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate server api call
    if (saveBeneficiary) {
      final exists = _mockBeneficiaries.any((b) => b.cardNumber == cardNumber);
      if (!exists) {
        _mockBeneficiaries.add(
          Beneficiary(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            name: beneficiaryName,
            cardNumber: cardNumber,
          ),
        );
      }
    }
    return true;
  }
}
