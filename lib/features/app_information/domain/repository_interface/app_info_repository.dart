import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/app_information/domain/entities/app_info_entity.dart';

abstract class AppInfoRepository {
  Future<ApiResult<AppInfoEntity>> getAppInfo();
}
