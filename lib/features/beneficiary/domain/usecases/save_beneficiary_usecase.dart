import 'package:easy_pay_app/core/network/api_result.dart';
import '../entities/beneficiary.dart';
import '../repositories/beneficiary_repository.dart';

class SaveBeneficiaryUseCase {
  final BeneficiaryRepository repository;

  SaveBeneficiaryUseCase(this.repository);

  Future<ApiResult<bool>> call(Beneficiary beneficiary) async {
    return await repository.saveBeneficiary(beneficiary);
  }
}
