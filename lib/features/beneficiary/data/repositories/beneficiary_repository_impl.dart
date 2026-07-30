import 'package:easy_pay_app/core/network/api_result.dart';
import '../../domain/entities/beneficiary.dart';
import '../../domain/repositories/beneficiary_repository.dart';
import '../../../transfer/data/models/mock_transfer_data.dart';

class BeneficiaryRepositoryImpl implements BeneficiaryRepository {
  // Use the same mock list for backward-compatibility and data sharing
  final List<Beneficiary> _mockBeneficiaries = mockBeneficiaries;

  @override
  Future<ApiResult<List<Beneficiary>>> getBeneficiaries() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return ApiSuccess(data: _mockBeneficiaries);
  }

  @override
  Future<ApiResult<bool>> saveBeneficiary(Beneficiary beneficiary) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final exists = _mockBeneficiaries.any((b) => b.cardNumber == beneficiary.cardNumber);
    if (!exists) {
      _mockBeneficiaries.add(beneficiary);
    } else {
      final idx = _mockBeneficiaries.indexWhere((b) => b.cardNumber == beneficiary.cardNumber);
      if (idx != -1) {
        _mockBeneficiaries[idx] = beneficiary;
      }
    }
    return const ApiSuccess(data: true);
  }
}
