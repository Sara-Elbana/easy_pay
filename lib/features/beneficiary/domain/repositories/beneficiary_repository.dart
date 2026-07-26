import '../entities/beneficiary.dart';

abstract class BeneficiaryRepository {
  Future<List<Beneficiary>> getBeneficiaries();
  Future<bool> saveBeneficiary(Beneficiary beneficiary);
}
