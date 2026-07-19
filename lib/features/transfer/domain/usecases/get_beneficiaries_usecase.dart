import '../entities/beneficiary.dart';
import '../repositories/transfer_repository.dart';

class GetBeneficiariesUseCase {
  final TransferRepository repository;

  GetBeneficiariesUseCase(this.repository);

  Future<List<Beneficiary>> call() async {
    return await repository.getBeneficiaries();
  }
}
