import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/app_information/domain/entities/app_info_entity.dart';
import 'package:easy_pay_app/features/app_information/domain/repository_interface/app_info_repository.dart';

class GetAppInfoUseCase {
  final AppInfoRepository repository;

  GetAppInfoUseCase(this.repository);

  Future<ApiResult<AppInfoEntity>> call() async {
    return await repository.getAppInfo();
  }
}
