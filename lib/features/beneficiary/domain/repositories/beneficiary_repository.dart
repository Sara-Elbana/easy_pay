import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/beneficiary/data/models/requests/save_beneficiary_request.dart';
import '../entities/beneficiary.dart';

abstract class BeneficiaryRepository {
  Future<ApiResult<List<Beneficiary>>> getBeneficiaries();
  Future<ApiResult<bool>> saveBeneficiary(SaveBeneficiaryRequest request);
}
