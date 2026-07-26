import '../entities/beneficiary.dart';
import '../repositories/beneficiary_repository.dart';

class SaveBeneficiaryUseCase {
  final BeneficiaryRepository repository;

  SaveBeneficiaryUseCase(this.repository);

  Future<bool> call(Beneficiary beneficiary) async {
    return await repository.saveBeneficiary(beneficiary);
  }
}
