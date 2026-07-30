import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/profile/domain/entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<ApiResult<ProfileEntity>> getProfile();
}
