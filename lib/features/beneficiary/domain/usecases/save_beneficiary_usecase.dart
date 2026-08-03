import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/beneficiary/data/models/requests/save_beneficiary_request.dart';
import '../repositories/beneficiary_repository.dart';

class SaveBeneficiaryUseCase {
  final BeneficiaryRepository repository;

  SaveBeneficiaryUseCase(this.repository);

  Future<ApiResult<bool>> call(SaveBeneficiaryRequest request) async {
    return await repository.saveBeneficiary(request);
  }
}
