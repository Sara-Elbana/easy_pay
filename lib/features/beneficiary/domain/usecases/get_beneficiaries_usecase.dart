import 'package:easy_pay_app/core/network/api_result.dart';
import '../entities/beneficiary.dart';
import '../repositories/beneficiary_repository.dart';

class GetBeneficiariesUseCase {
  final BeneficiaryRepository repository;

  GetBeneficiariesUseCase(this.repository);

  Future<ApiResult<List<Beneficiary>>> call() async {
    return await repository.getBeneficiaries();
  }
}
