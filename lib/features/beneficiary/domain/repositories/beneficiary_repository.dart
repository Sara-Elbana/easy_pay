import 'package:easy_pay_app/core/network/api_result.dart';
import '../entities/beneficiary.dart';

abstract class BeneficiaryRepository {
  Future<ApiResult<List<Beneficiary>>> getBeneficiaries();
  Future<ApiResult<bool>> saveBeneficiary(Beneficiary beneficiary);
}
