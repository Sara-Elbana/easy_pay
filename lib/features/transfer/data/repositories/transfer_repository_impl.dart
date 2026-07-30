import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/transfer/data/models/requests/transfer_request.dart';
import '../../../beneficiary/domain/entities/beneficiary.dart';
import '../../domain/entities/transfer_card.dart';
import '../../domain/repositories/transfer_repository.dart';
import '../models/mock_transfer_data.dart';

class TransferRepositoryImpl implements TransferRepository {
  // Use mock lists from mock_transfer_data.dart
  final List<TransferCard> _mockCards = mockCards;
  final List<Beneficiary> _mockBeneficiaries = mockBeneficiaries;

  @override
  Future<ApiResult<List<TransferCard>>> getCards() async {
    // Simulate API network delay
    await Future.delayed(const Duration(milliseconds: 300));
    return ApiSuccess(data: _mockCards);
  }

  @override
  Future<ApiResult<bool>> executeTransfer(TransferRequest request) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate server api call
    if (request.saveBeneficiary) {
      final exists = _mockBeneficiaries.any((b) => b.cardNumber == request.cardNumber);
      if (!exists) {
        _mockBeneficiaries.add(
          Beneficiary(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            name: request.beneficiaryName,
            cardNumber: request.cardNumber,
            type: request.type ?? 0,
            bank: request.bank,
            branch: request.branch,
          ),
        );
      }
    }
    return const ApiSuccess(data: true);
  }
}
