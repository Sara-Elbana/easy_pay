import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/profile/domain/entities/profile_entity.dart';
import 'package:easy_pay_app/features/profile/domain/repository_interface/profile_repository_interface.dart';

class GetProfileUseCase {
  final ProfileRepository repository;

  GetProfileUseCase(this.repository);

  Future<ApiResult<ProfileEntity>> call() async {
    return await repository.getProfile();
  }
}
