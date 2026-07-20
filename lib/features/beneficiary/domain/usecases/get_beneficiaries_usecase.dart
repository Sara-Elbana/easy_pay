import '../entities/beneficiary.dart';
import '../repositories/beneficiary_repository.dart';

class GetBeneficiariesUseCase {
  final BeneficiaryRepository repository;

  GetBeneficiariesUseCase(this.repository);

  Future<List<Beneficiary>> call() async {
    return await repository.getBeneficiaries();
  }
}
